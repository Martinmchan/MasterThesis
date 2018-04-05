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

int main(int argc, char** argv) {
	SSHMaster master;
	int call = system("rm ./json/*; wait");
	call = system("rm ./tmp/*; wait");
	makeJson();
	vector<string> ips = readIPs();

	master.connect(ips,"pass");
	
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
	master.transferRemote(ips, fromJson, to);
	master.transferRemote(ips, fromAudioNetSend, to);

	vector<string> command1;
	vector<string> command2;
	vector<string> command3;
	vector<string> command4;
	
	for (int i = 1; i < ips.size() + 1; i++){
		
		
	}



	
	return 0;
}
