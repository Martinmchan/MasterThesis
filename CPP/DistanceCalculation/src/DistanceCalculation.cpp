#include "WavReader.h"
//#include "Goertzel.h"
#include "Recording.h"
#include "Matrix.h"
#include "DeltaContainer.h"
#include "Settings.h"
#include "Run.h"

#include <libnessh/SSHMaster.h>

#include <iostream>
#include <algorithm>
#include <chrono>
#include <fstream>
#include <sstream>
#include <cmath>

#define EPSILON	(0.01)

#define ERROR(...)	do { fprintf(stderr, "Error: "); fprintf(stderr, __VA_ARGS__); fprintf(stderr, "\n"); exit(1); } while(0)

using namespace std;

Settings g_settings;

int g_playingLength = 2e05;

/* Not currently used
static bool equal(double a, double b) {
	return abs(a - b) < EPSILON;
}

static bool isNaN(double a) {
	return a != a;
}
*/

double calculateDistance(Recording& master, Recording& recording) {
	long long r12 = recording.getTonePlayingWhen(master.getId());
	long long p1 = master.getTonePlayingWhen(master.getId());
	long long r21 = master.getTonePlayingWhen(recording.getId());
	long long p2 = recording.getTonePlayingWhen(recording.getId());
	
	//T12 = Tp + Dt
	//T21 = Tp - Dt
	double T12 = r12 - p1;
	double T21 = r21 - p2;
	
	double Dt = -(static_cast<double>(T21) - static_cast<double>(T12)) / 2;
	
	double Tp1 = T12 - Dt;
	double Tp2 = T21 + Dt;
	
	double Tp = (Tp1 + Tp2) / 2;
	double Tp_sec = Tp / 48000;
	
	return abs(Tp_sec * 343);
	}

void printHelp() {
	/*
	cout << "Usage: ./GoertzelLocalization <pause length in seconds> <speaker #1 IP> <speaker #2 IP>\n\n# of speakers is arbitrary\n\n1. Creates configuration files for every speaker based on IP, and sends"
		 <<	" the files using scp\n2. Starts the scripts at the same time\n3. Wait until done\n4. Retrieve all recordings from the speakers\n5. Calculate distances using Goertzel\n\n";
	*/
	
	cout << "Usage: DistanceCalculation [-options]\n\n";
	cout << "Runs the localization test using Goertzel algorithm to detect sound.\n\n";
	cout << "Options:\n";
	cout << "\t-p,\t\t specify pause length in seconds between beeps\n";
	cout << "\t-er,\t\t specify extra recording length, will be added after the beeps\n";
	cout << "\t-h,\t\t print this help text\n";
	cout << "\t-f,\t\t specify file with IPs, with the format of one IP address per line\n";
	cout << "\t-t,\t\t specify which mode to run, default is GOERTZEL, other modes are NOTHING, WHITE_NOISE (just collects the sound samples)\n";
	cout << "\t-tf,\t\t specify the test file to run (place it in data/, should be 1 s 48 kHZ, default is testTone.wav)\n";
	cout << "\t-jr,\t\t don't run the full script, just read the values from recordings/ directly (default is FALSE)\n";
	cout << "\t-ws,\t\t write server output (default is FALSE)\n";
}

string createConfig(string& ip, int number, int duration) {
	int extra_record = 0;
	
	if (g_settings.has("-er"))
		extra_record = g_settings.get<int>("-er");
		
	string config = "";
	config += "systemctl stop audio*\n";
	config += "arecord -Daudiosource -r 48000 -fS16_LE -c1 -d";
	config += to_string(duration + extra_record);
	config += " /tmp/cap";
	config += ip;
	config += ".wav &\n";
	config += "\n";
	config += "sleep ";
	config += to_string(-1 + (g_playingLength / 48000 * (number + 1)));
	config += "\n";
	//config += "aplay -Dlocalhw_0 -r 48000 -fS16_LE /tmp/testTone.wav\n\nexit;\n";
	config += "aplay -Dlocalhw_0 -r 48000 -f S16_LE /tmp/";
	config += (g_settings.has("-tf") ? g_settings.get<string>("-tf") : "testTone.wav");
	config += "\n\nexit;\n";
	
	return config;
}

vector<string> createFilenames(vector<string>& configs) {
	vector<string> filenames;
	
	for (auto& ip : configs) {
		string filename = "recordings/cap";
		//string filename = "../backups/level_3_distances/recordings/cap";
		filename += ip;
		filename += ".wav";
		
		filenames.push_back(filename);
		
		//cout << "Creating filename: " << filename << endl;
	}
	
	return filenames;
}

vector<string> runSetup(const vector<string>& ips) {//int num_recordings, char** ips) {
	SSHMaster ssh_master;
	
	vector<string> configs(ips);//ips, ips + num_recordings);
	vector<string> files;
	int num_recordings = ips.size();
	int extra_record = 0;
	
	if (g_settings.has("-er"))
		extra_record = g_settings.get<int>("-er");
		
	int duration = g_playingLength /* until first tone */ + num_recordings * g_playingLength + g_playingLength /* to make up for jitter */;
	int duration_seconds = (duration / 48000);
	
	cout << "Using " << (g_settings.has("-tf") ? g_settings.get<string>("-tf") : "testTone.wav") << " as test file\n";
	cout << "Connecting to speakers using SSH.. ";
	
	if (!ssh_master.connect(configs, "pass"))
		ERROR("ssh connection failed");
		
	cout << "done\n";
	
	if (!system(NULL))
		ERROR("system calls are not available");
		
	int call = system("mkdir scripts; wait");
	call = system("mkdir recordings; wait");
	
	if (call) {} // Hide warnings
	
	cout << "Creating config files.. ";
	
	for (size_t i = 0; i < configs.size(); i++) {
		string& ip = configs.at(i);
		
		string filename = "scripts/script";
		filename += ip;
		filename += ".sh";
		
		files.push_back(filename);
		
		ofstream file(filename);
		
		if (!file.is_open()) {
			cout << "Warning: could not open file " << filename << endl;
			continue;
		}
		
		file << createConfig(ip, i, duration_seconds);
		
		file.close();
	}
	
	call = system("chmod +x scripts/*; wait");
	
	cout << "done\n";
	
	cout << "Transferring scripts and test files.. ";
	
	vector<string> from;
	vector<string> to;
	
	for (size_t i = 0; i < files.size(); i++) {
		//string file = "data/testTone.wav " + files.at(i);
		string file = "data/";
		file += (g_settings.has("-tf") ? g_settings.get<string>("-tf") : "testTone.wav");
		file += " ";
		file += files.at(i);
		
		from.push_back(file);
		to.push_back("/tmp/");
	}
	
	if (!ssh_master.transferRemote(configs, from, to))
		ERROR("error transferring scripts and test tones");
	
	cout << "done\n";
	
	cout << "Running scripts at remotes.. ";
	
	vector<string> commands;
	
	for (auto& ip : configs)
		commands.push_back("chmod +x /tmp/script" + ip + ".sh; /tmp/script" + ip + ".sh");
	
	if (!ssh_master.command(configs, commands))
		ERROR("could not command ssh");

	cout << "done, waiting for finish\n";
	
	for (int i = 0; i < duration_seconds + 1 + extra_record; i++) {
		sleep(1);
		printf("%d/%d seconds elapsed (%1.0f%%)\n", (i + 1), duration_seconds + extra_record + 1, (static_cast<double>(i + 1) / (duration_seconds + extra_record + 1)) * 100.0);
	}
	
	cout << "Downloading recordings.. ";
	
	//vector<string> from;
	//vector<string> to;
	from.clear();
	to.clear();
	
	for (auto& ip : configs) {
		from.push_back("/tmp/cap" + ip + ".wav");
		to.push_back("recordings");
	}
		
	if (!ssh_master.transferLocal(configs, from, to, true))
		ERROR("could not retrieve recordings");
	
	cout << "done\n";
	
	cout << "Creating filenames.. ";
	auto filenames = createFilenames(configs);
	cout << "done\n\n";
	
	return filenames;
}

bool checkParameters(int argc, char** argv) {
	argc--;
	argv++;
	
	g_settings.set("-h", "0");
	
	for (int i = 0; i < argc; i += 2) {
		string option = string(argv[i]);
		
		if (i + 1 >= argc)
			return false;
			
		string value = argv[i + 1];
		
		g_settings.set(option, value);
	}
	
	if (!g_settings.has("-f")) {
		cout << "Error: no file specified\n\n";
		
		return false;
	}
	
	return true;
}

vector<string> readIps(const string& filename) {
	ifstream file(filename);
	
	if (!file.is_open())
		ERROR("could not open file %s", filename.c_str());
		
	vector<string> ips;
	string ip;	
		
	while (getline(file, ip))
		ips.push_back(ip);
		
	file.close();	
		
	return ips;	
}

int main(int argc, char** argv) {
	/*
		0: program path
		1: pause length in seconds
		2: recording speaker # 1 IP
		3: recording speaker # 2 IP
	*/
	
	/*
		script runs test tone at 4000 hz and 1 sec, 60000 samples
	*/	
	
	if (!checkParameters(argc, argv) || g_settings.get<bool>("-h")) {
		printHelp();
		
		return -1;
	}
	
	if (g_settings.has("-p"))
		g_playingLength = g_settings.get<int>("-p") * 48000;
	else
		g_playingLength = 2 * 48000;
	
	vector<Recording> recordings;
	
	vector<string> ips = readIps(g_settings.get<string>("-f"));
	
	int setting_js = JUST_RUN_FULL;
	
	if (g_settings.has("-jr"))
		if (g_settings.get<string>("-jr") == "TRUE")
			setting_js = JUST_RUN_SIMPLE;
		
	vector<string> filenames = setting_js == JUST_RUN_FULL ? runSetup(ips) : createFilenames(ips);
		
	int run_type = RUN_GOERTZEL;
		
	if (g_settings.has("-t")) {
		string type = g_settings.get<string>("-t");
		
		// Add more run types here
		if (type == "NOTHING")
			run_type = RUN_NOTHING;
		else if (type == "WHITE_NOISE")
			run_type = RUN_WHITE_NOISE;
	}
	
	switch (run_type) {
		case RUN_GOERTZEL: Run::runGoertzel(filenames, ips);
			break;
			
		case RUN_WHITE_NOISE: Run::runWhiteNoise(filenames, ips);
			break;
			
		case RUN_NOTHING:
			break;
			
		default: ERROR("no running mode specified");
			break;
	}
		
	return 0;
}
