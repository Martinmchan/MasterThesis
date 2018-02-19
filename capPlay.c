#include <stdio.h>
#include <stdlib.h>
#include <alsa/asoundlib.h>
#include <unistd.h>
//#include <time.h>
#define PCM_PLAYER "plughw:1,0,0"
#define PCM_RECORDER "audiosource"

int main(){
	//Initialization and settings for record and play
	int rate = 48000;
	int channels = 1;
	snd_pcm_hw_params_t *params;
	snd_pcm_uframes_t frames;
	snd_pcm_format_t format = SND_PCM_FORMAT_S16_LE;
	int i, size;

	FILE *rawFile = fopen("CP.raw", "w");
	FILE *timeFile = fopen("CP.txt", "w");
	fclose(timeFile);
	timeFile = fopen("CP.txt", "a");

	//Initializing the needed variables and settings for record
	int buffFrames = 128;
	size = buffFrames * snd_pcm_format_width(format) / 8 * 2;
	snd_pcm_t *recHandler;
	char *recBuffer;

	//Preparing for record
	snd_pcm_open(&recHandler, PCM_RECORDER, SND_PCM_STREAM_CAPTURE, 0);
	snd_pcm_hw_params_malloc(&params);
	snd_pcm_hw_params_any(recHandler, params);
	snd_pcm_hw_params_set_access(recHandler, params, SND_PCM_ACCESS_RW_INTERLEAVED);
	snd_pcm_hw_params_set_format(recHandler, params, format);
	snd_pcm_hw_params_set_rate_near(recHandler, params, &rate, 0);
	snd_pcm_hw_params_set_channels(recHandler, params, channels);
	snd_pcm_hw_params (recHandler, params);
	snd_pcm_prepare (recHandler);


	recBuffer = malloc(size);

	//Get first time stamp	
  	/*struct timeval currentTimeC;
	gettimeofday(&currentTimeC, NULL);*/
	//snd_pcm_status_t *recStatus;
	//snd_htimestamp_t recStamp;
	//snd_pcm_status_malloc(&recStatus);

//	snd_pcm_status(recHandler, recStatus);
	
	/* Timestamp från senaste framen capturad till underliggande buffer */
//	snd_pcm_status_get_htstamp(recStatus, &recStamp);

//	unsigned long long time_ns = (recStamp.tv_sec * ((unsigned long long) 1e9)) + recStamp.tv_nsec;

	/* Hur många frames fanns buffrade? */
//	snd_pcm_uframes_t avail = snd_pcm_status_get_avail(recStatus);

	/* Hur lång tid motsvarar de? */
//	unsigned long long time_ns_buffer = (avail * ((unsigned long long) 1e9)) / rate;

	/* Subtrahera buffertid för att få capture tid för första utlästa samples från read. */
//	time_ns -= time_ns_buffer;
	

	//Start recording
	for (i = 0; i < 2000; ++i) {
    		snd_pcm_readi(recHandler, recBuffer, buffFrames);
    		fwrite(recBuffer, sizeof(recBuffer[0]), 256, rawFile);	
	}
	
//	fprintf(timeFile, "%lld \n \n",);
	free(recBuffer);
  	fclose(rawFile);
  	snd_pcm_close(recHandler);

	//Initializing the needed variables and settings for playback
	int playTime = 1;

	snd_pcm_t *playHandler;
	char *playBuffer;
	unsigned int periodT;
	
	//Preparing for playback
	snd_pcm_open(&playHandler, PCM_PLAYER, SND_PCM_STREAM_PLAYBACK, 0);
	snd_pcm_hw_params_alloca(&params);
	snd_pcm_hw_params_any(playHandler, params);
	snd_pcm_hw_params_set_access(playHandler, params, SND_PCM_ACCESS_RW_INTERLEAVED);
	snd_pcm_hw_params_set_format(playHandler, params, format);
	snd_pcm_hw_params_set_channels(playHandler, params, channels);
	snd_pcm_hw_params_set_rate_near(playHandler, params, &rate, 0);
	snd_pcm_hw_params(playHandler, params);


	snd_pcm_hw_params_get_period_size(params, &frames, 0);
	size = frames * channels * 2;
	playBuffer = (char *) malloc(size);
	snd_pcm_hw_params_get_period_time(params, &periodT, NULL);

	//Get the second time stamp
	/*struct timeval currentTimeP;
	gettimeofday(&currentTimeP, NULL);*/
	
//	snd_pcm_status_t *playStatus;
//	snd_htimestamp_t playStamp;
//	snd_pcm_status_malloc(&playStatus);
//
//	snd_pcm_status(playHandler, playStatus);

	/* Timestamp från senaste framen capturad till underliggande buffer */
//	snd_pcm_status_get_htstamp(playStatus, &playStamp);

//	time_ns = (playStamp.tv_sec * ((unsigned long long) 1e9)) + playStamp.tv_nsec;

	/* Hur många frames fanns buffrade? */
//	avail = snd_pcm_status_get_avail(playStatus);

	/* Hur lång tid motsvarar de? */
//	time_ns_buffer = (avail * ((unsigned long long) 1e9)) / rate;

	/* Subtrahera buffertid för att få capture tid för första utlästa samples från read. */
//	time_ns -= time_ns_buffer;

	//Start playback
	for (i = (playTime * 1000000) / periodT; i > 0; i--) {
		read(0, playBuffer, size);
		fprintf(stdout, "frames filled: %d \n",snd_pcm_writei(playHandler, playBuffer, frames));
	}
		
//	fprintf(timeFile, "%lld \n \n", time_ns);
	snd_pcm_drain(playHandler);
	snd_pcm_close(playHandler);
	free(playBuffer);
//	free(playStatus);
//	free(recStatus);	

	//Write the times on file
	//long long int timeStampC = currentTimeC.tv_sec * (int)1e6 + currentTimeC.tv_usec;
	//fprintf(timeFile, "%lld \n \n", timeStampC);
	//long long int timeStampP = currentTimeP.tv_sec * (int)1e6 + currentTimeP.tv_usec;
	//fprintf(timeFile, "%lld \n", timeStampP);
	fclose(timeFile);

	return 0;

}
