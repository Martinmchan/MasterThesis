#include <libnessh/SSHMaster.h>
#include <iostream>
#include <fstream>
#define ERROR(...)	do { fprintf(stderr, "Error: "); fprintf(stderr, __VA_ARGS__); fprintf(stderr, "\n"); exit(1); } while(0)

using namespace std;

void makeJson() {
	string line;
	ifstream confFile("./configuration.txt");
	if (confFile.is_open()){
		getline(confFile, line);
		string compID = line;
		getline(confFile, line);
		int nbrIP = stoi(line);
		getline(confFile, line);
		string clockIP = line;

		int i;
		for(i = 0 ; i < nbrIP ; i++) {
			ofstream jsonFile("./json/mic" + to_string(i+1) + ".json");
			jsonFile << "{\n  \"Source\": {\n    \"Type\": \"alsa\",\n    \"AlsaDevice\": \"audiosource\"\n  },\n";
			jsonFile << "  \"Sinks\": [\n    {\n      \"Port\": "+ to_string(6000+i*2) +",\n      \"Address\":\""+ compID + "\"\n    }\n  ],\n";
			jsonFile << "  \"Profile\": \"default\",\n  \"Enabled\": true,\n  \"Clock\": {\n    \"Type\": \"gstnet\",\n    \"Address\": \""+ clockIP +"\",\n    \"Port\": 5015\n  }\n}";
			jsonFile.close();
		}
    		confFile.close();
  	}
}

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
	int call = system("rm ./json/*; wait");
	makeJson();
	vector<string> ips = readIPs();
	if (!master.connect(ips,"pass"))
		cout << "Could not connect to speakers\n";
	
	vector<string> fromJson;
	vector<string> fromAudioNetSend;

	vector<string> to;
	for (int i = 1; i < ips.size() + 1; i++){
		string filename = "./json/mic";
		filename += to_string(i);
		filename += ".json";
		fromJson.push_back(filename);
		fromAudioNetSend.push_back("./audio-netsend");
		to.push_back("/tmp/");
		
	}

	master.setSetting(SETTING_ENABLE_SSH_OUTPUT_VECTOR_STYLE, true);

	master.transferRemote(ips, fromJson, to);
	master.transferRemote(ips, fromAudioNetSend, to);
	
	string command;
	vector<string> commands;

	for (int i = 1; i < ips.size() + 1; i++) {
		command = "cd /tmp; mkfifo mic" + to_string(i) + ".json.in; wait;";
		commands.push_back(command);
	}
	printSSHOutput(master.command(ips, commands, true));

	commands.clear();
	for (int i = 1; i < ips.size() + 1; i++) {
		command = "cd /tmp; mkfifo mic" + to_string(i) + ".json.out; wait;";
		commands.push_back(command);
	}
	printSSHOutput(master.command(ips, commands, true));

	commands.clear();
	for (int i = 1; i < ips.size() + 1; i++) {
		command = "cd /tmp; chmod +x audio-netsend; wait;";
		commands.push_back(command);
	}
	printSSHOutput(master.command(ips, commands, true));

	commands.clear();
	for (int i = 1; i < ips.size() + 1; i++) {
		command = "cd /tmp\n./audio-netsend mic" + to_string(i) + ".json &";
		commands.push_back(command);
	}
	printSSHOutput(master.command(ips, commands, true));
	
	return 0;
}
