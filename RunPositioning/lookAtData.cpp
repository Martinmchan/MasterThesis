#include <iostream>
#include <fstream>
#include <libnessh/SSHMaster.h>

using namespace std;

vector<string> readIPs(){
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
	system("rm ./tmp/*; wait");
	string line;
	ifstream confFile("./configuration.txt");
	vector<string> ips = readIPs();
	
	master.connect(ips, "pass");
	
	vector<string> from;
	vector<string> to;
	for (int i = 0; i < ips.size(); i++) {
		from.push_back("/var/spool/storage/SD_DISK/tmp" + to_string(i+1) + ".wav");
		to.push_back("tmp");
	}
	
	master.transferLocal(ips, from, to, true);


	system("../../bin/matlab -nodesktop -nosplash -r \"run ./MATLAB/mainFunction.m\"");
	return 0;
}
