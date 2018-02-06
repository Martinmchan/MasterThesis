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
	
	sleep(6);
	

	//Start playback
	for (i = (playTime * 1000000) / periodT; i > 0; i--) {
		read(0, playBuffer, size);
		snd_pcm_writei(playHandler, playBuffer, frames);
	}
	
	snd_pcm_drain(playHandler);
	snd_pcm_close(playHandler);
	free(playBuffer);

	return 0;

}
