#include <libnessh/SSHMaster.h>
#include <iostream>
#include <fstream>
#define ERROR(...)	do { fprintf(stderr, "Error: "); fprintf(stderr, __VA_ARGS__); fprintf(stderr, "\n"); exit(1); } while(0)

using namespace std;

const vector<string> readIPs(){
	ifstream confFile("./configuration.txt");
	vector<string> ips;
	string line;
	if(confFile.is_open()){
		getline(confFile, line);
		getline(confFile, line);
		int nbrIP = stoi(line);
		for (int i = 0; i < nbrIP; i++){
			getline(confFile, line);
			ips.push_back(line);
		}
		
	}
	return ips;
}


void printSSHOutput(const vector<pair<string, vector<string>>>& output) {
	for (auto& peer : output) {
		cout << "Output for " << peer.first << endl;

		for (auto& line : peer.second)
			cout << "Line: " << line << endl;
	}
}	



int main(int argc, char** argv) {
	SSHMaster master;
	vector<string> ips = readIPs();
	if (!master.connect(ips,"pass"))
		cout << "Could not connect to speakers\n";
	
	if (argc == 0)
		cout << "Could not start recordning, enter record time";	
	
	vector<string> commands;
	for (int i = 1; i < ips.size() + 1; i++) {
		if (i == 0) {
			string command = "cd /tmp; chrt -f 5 arecord -Daudiosource -fS16_LE -r48000 -d" + string(argv[1]) + " tmp" + to_string(i) + ".wav & \n sleep 2; cd /tmp ;aplay -Dlocalhw_0 ring1mod.wav; wait";
			commands.push_back(command);
		} else {
			string command = "cd /tmp; chrt -f 5 arecord -Daudiosource -fS16_LE -r48000 -d" + string(argv[1]) + " tmp" + to_string(i) + ".wav; wait;";
			commands.push_back(command);
		}
	}

	printSSHOutput(master.command(ips, commands));
	
	return 0;
}
