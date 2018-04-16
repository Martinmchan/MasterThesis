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

int main(int argc, char** argv) {
	SSHMaster master;
	vector<string> ips = readIPs();
	if (!master.connect(ips,"pass"))
		cout << "Could not connect to speakers\n";
	
	if (argc == 0)
		cout << "Could not start recordning, enter record time"	
	
	for (int i = 1; i < ips.size() + 1; i++) {
		command = "cd /var/spool/storage/SD_DISK; arecord -Daudiosource -fS16_LE -r48000 -d" + to_string(argv[0]) + " mic" + to_string(i) + ".wav; wait;";
		commands.push_back(command);
	}
	master.command(ips, commands, true);

	printSSHOutput(master.command(ips, commands, true));
	
	return 0;
}
