#include <stdio.h>
#include <stdlib.h>
#include <alsa/asoundlib.h>
//.miniPlayCap audiosource localhw:0 test.wav



#include <alsa/asoundlib.h>
#include <stdio.h>

#define PCM_DEVICE "default"

int main(int argc, char **argv) {
	unsigned int pcm, tmp, dir;
	int rate, channels, seconds;
	snd_pcm_t *pcm_handle;
	snd_pcm_hw_params_t *params;
	snd_pcm_uframes_t frames;
	char *buff;
	int buff_size, loops;
	rate 	 = 48000;
	channels = 1;
	seconds  = 2;

	snd_pcm_open(&pcm_handle, PCM_DEVICE, SND_PCM_STREAM_PLAYBACK, 0);
	snd_pcm_hw_params_alloca(&params);
	snd_pcm_hw_params_any(pcm_handle, params);
	snd_pcm_hw_params_set_access(pcm_handle, params, SND_PCM_ACCESS_RW_INTERLEAVED);
	snd_pcm_hw_params_set_format(pcm_handle, params, SND_PCM_FORMAT_S16_LE); 
	snd_pcm_hw_params_set_channels(pcm_handle, params, channels);
	snd_pcm_hw_params_set_rate_near(pcm_handle, params, &rate, 0); 
	snd_pcm_hw_params(pcm_handle, params);

	snd_pcm_hw_params_get_channels(params, &tmp);

	/* Allocate buffer to hold single period */
	snd_pcm_hw_params_get_period_size(params, &frames, 0);

	buff_size = frames * channels * 2;
	buff = (char *) malloc(buff_size);

	snd_pcm_hw_params_get_period_time(params, &tmp, NULL);

	for (loops = (seconds * 1000000) / tmp; loops > 0; loops--) {
		read(0, buff, buff_size);
		snd_pcm_writei(pcm_handle, buff, frames);
	}

	snd_pcm_drain(pcm_handle);
	snd_pcm_close(pcm_handle);
	free(buff);

	return 0;
}
