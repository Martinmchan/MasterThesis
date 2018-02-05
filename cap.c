#include <stdio.h>
#include <stdlib.h>
#include <alsa/asoundlib.h>
#include <unistd.h>
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

	FILE *rawFile = fopen("cap.raw", "w");
	FILE *timeFile = fopen("cap.txt", "a");

	//Initializing the needed variables and settings for record
	int buffFrames = 128;
	size = buffFrames * snd_pcm_format_width(format) / 8 * channels;

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
  	struct timeval currentTimeC;
	gettimeofday(&currentTimeC, NULL);
	
	
	fprintf(stdout,"Now recording!!!!");	
	
	//Start recording
	for (i = 0; i < 4000; ++i) {
    		snd_pcm_readi(recHandler, recBuffer, buffFrames);
    		fwrite(recBuffer, sizeof(recBuffer[0]), size, rawFile);	
	}
	
	fprintf(stdout,"Recording done!!!!");
	
	free(recBuffer);
  	fclose(rawFile);
  	snd_pcm_close(recHandler);

	long long int timeStampC = currentTimeC.tv_sec * (int)1e6 + currentTimeC.tv_usec;
	fprintf(timeFile, "%lld \n \n", timeStampC);

	return 0;
}
