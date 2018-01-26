#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

main () {
	
	//Get timestamp for recording
	struct timeval currentTimeC;
	gettimeofday(&currentTimeC, NULL);
	
	int i;
	int seconds = 2;
	for (i = 0; i < seconds*5/2; ++i){	
		fprintf(stdout, "hejhej \n");	
	}
	

	struct timeval currentTimeP;
	gettimeofday(&currentTimeP, NULL);
	

	long long int timeStampC = currentTimeC.tv_sec * (int)1e6 + currentTimeC.tv_usec;
	fprintf(stdout, "%lld \n", timeStampC);
	long long int timeStampP = currentTimeP.tv_sec * (int)1e6 + currentTimeP.tv_usec;
	fprintf(stdout, "%lld \n", timeStampP);


}
