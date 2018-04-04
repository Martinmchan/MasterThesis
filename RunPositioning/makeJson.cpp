#include <fstream>
#include <iostream>
using namespace std;

int main()
{
	string line;
	ifstream confFile("configuration.txt");
	if (confFile.is_open()){

		getline(confFile, line);
		string compID = line;
		getline(confFile, line);
		int nbrIP = stoi(line);
		getline(confFile, line);
		string clockIP = line;

		int i;
		for(i = 1 ; i <= nbrIP ; i++) {
			ofstream jsonFile("./json/mic" + to_string(i) + ".json");
			jsonFile << "{\n  \"Source\": {\n    \"Type\": \"alsa\",\n    \"AlsaDevice\": \"audiosource\"\n  },\n";
			jsonFile << "  \"Sinks\": [\n    {\n      \"Port\": "+ to_string(6000+i*2) +",\n      \"Address\":\""+ compID + "\"\n    }\n  ],\n";
			jsonFile << "  \"Profile\": \"default\",\n  \"Enabled\": true,\n  \"Clock\": {\n    \"Type\": \"gstnet\",\n    \"Address\": \""+ clockIP +"\",\n    \"Port\": 5015\n  }\n}";
			jsonFile.close();
		}
    		confFile.close();
  	}
   	return 0;
}

