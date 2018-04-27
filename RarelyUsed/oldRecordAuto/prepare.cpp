#include <libnessh/SSHMaster.h>
#include <iostream>
#include <fstream>
#define ERROR(...)	do { fprintf(stderr, "Error: "); fprintf(stderr, __VA_ARGS__); fprintf(stderr, "\n"); exit(1); } while(0)

using namespace std;	

int main(int argc, char** argv) {
	SSHMaster master;

	
	string line;
	ifstream confFile("./configuration.txt");
	if (confFile.is_open()){
		getline(confFile, line);
		getline(confFile, line);
		getline(confFile, line);
		vector<string> speakerIP; 
		speakerIP.push_back(line);


		if (!master.connect(speakerIP,"pass"))
		cout << "Could not connect to speakers\n";


		string command;
		vector<string> commands;

		command = "dspd -s -b loudness; dspd -s -b compressor; dspd -s -b preset; dspd -s -b hpf; dspd -s -b vad; dspd -s -b mic; wait;";
		commands.push_back(command);
		
		master.command(speakerIP, commands);

		commands.clear();
		command = "killall audio-netrecv; wait;";
		commands.push_back(command);
		
		master.command(speakerIP, commands);

		vector<string> from;
		vector<string> to;

		string filename = "./ring1mod.wav";
		from.push_back(filename);
		to.push_back("/tmp/");

	
		master.transferRemote(speakerIP, from, to);

	} else {
		cout << "Could not open Configuration.txt";
	}
	return 0;	
		
}
