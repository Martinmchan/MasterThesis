
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
main(){
FILE *timeFile = fopen("sshTime.txt", "a");
  struct timeval currentTime;
	
  gettimeofday(&currentTime, NULL);
  long long int timeStamp = currentTime.tv_sec * (int)1e6 + currentTime.tv_usec;
  
  
  fprintf(timeFile, "%lld \n", timeStamp);

  fclose(timeFile);

}
