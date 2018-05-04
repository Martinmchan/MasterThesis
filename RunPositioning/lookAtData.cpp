#include <iostream>
#include <fstream>


using namespace std;

int main(int argc, char** argv) {
	
	system("find ./tmp -name '*.wav' -delete");
	string line;
	ifstream confFile("./configuration.txt");
	int nbrIP;
	if (confFile.is_open()){
		getline(confFile, line);
		string compID = line;
		getline(confFile, line);
		nbrIP = stoi(line);
	}
	
	string ffmpegCall = "ffmpeg -f s16le -ar 48k -ac ";
	ffmpegCall += to_string(nbrIP);
	ffmpegCall += " -i ./tmp/tmp.raw ./tmp/tmp.wav; wait";	
	system(ffmpegCall.c_str());		
	ffmpegCall = "ffmpeg -i ./tmp/tmp.wav ";	
	
	for (int i = 1; i < nbrIP+1; i++){
		ffmpegCall += "-map_channel 0.0." + to_string(i-1) + " ./tmp/tmp" + to_string(i) + ".wav ";
	}
	ffmpegCall += "; wait";
	system(ffmpegCall.c_str());
	
	system("../../bin/matlab -nodesktop -nosplash -r \"run ./MATLAB/mainFunction.m\"");
	return 0;
}
