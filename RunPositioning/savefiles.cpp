#include <iostream>
#include <fstream>
#include <typeinfo>

using namespace std;

int main(int argc, char** argv) {
	
	if (argc != 2) {
		cout << "Please enter the prefix of your desired file names.";
		return 1;
	}

	ifstream confFile("./configuration.txt");
	string line;
	getline(confFile, line);
	getline(confFile, line);
	int nbrOfFiles = stoi(line);
	
	string command;
	char* prefix = argv[1];
	for (int i = 1; i < nbrOfFiles + 1; i++){
		command = "scp ./tmp/tmp" + to_string(i) + ".wav ./savedfiles/" + prefix + "mic" + to_string(i) + ".wav";
		system(command.c_str());
	}
	
	return 0;
}
