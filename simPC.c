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
	int i;

	FILE *rawFile = fopen("CP.raw", "w");


	//Initializing the needed variables and settings for record
	int buffFrames = 128;
	int sizeC = buffFrames * snd_pcm_format_width(format) / 8 * 2;

	snd_pcm_t *recHandler;
	char *recBuffer;

	//Initializing the needed variables and settings for playback
	int playTime = 1;

	snd_pcm_t *playHandler;
	char *playBuffer;
	unsigned int periodT;
	int sizeP;

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


	recBuffer = malloc(sizeC);

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
	sizeP = frames * channels * 2;
	playBuffer = (char *) malloc(sizeP);
	snd_pcm_hw_params_get_period_time(params, &periodT, NULL);
	
	fprintf(stdout, "periodT: %d ", periodT);

	//Start playback and record
	for (i = (playTime * 1000000) / periodT; i > 0; i--) {
		fprintf(stdout, "i : %d", i);	
		read(0, playBuffer, sizeP);
		snd_pcm_writei(playHandler, playBuffer, frames);
		snd_pcm_readi(recHandler, recBuffer, buffFrames);
    		fwrite(recBuffer, sizeof(recBuffer[0]), 256, rawFile);
	}
	
	free(recBuffer);
  	fclose(rawFile);
  	snd_pcm_close(recHandler);
	snd_pcm_drain(playHandler);
	snd_pcm_close(playHandler);
	free(playBuffer);
	

	return 0;

}
