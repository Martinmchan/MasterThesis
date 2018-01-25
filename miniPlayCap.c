#include <stdio.h>
#include <stdlib.h>
#include <alsa/asoundlib.h>
//.miniPlayCap audiosource localhw:0 test.wav


main (int argc, char *argv[]){
//Initialization for both play and record
	char *buffer;
	unsigned int pcm, tmp;
	int buffer_frames = 128;
	signed int rate = 48000;
	int channels = 1;
	int seconds = 8; 
	snd_pcm_t *handle;
	snd_pcm_hw_params_t *hw_params;
	snd_pcm_format_t format = SND_PCM_FORMAT_S16_LE;
	snd_pcm_uframes_t frames;
	int buff_size, loops;

//Prepare Speaker
	snd_pcm_open(&handle, argv[2], SND_PCM_STREAM_PLAYBACK, 0);
	snd_pcm_hw_params_alloca(&hw_params);
	snd_pcm_hw_params_any(handle, hw_params);
	snd_pcm_hw_params_set_access(handle, hw_params, SND_PCM_ACCESS_RW_INTERLEAVED);
	snd_pcm_hw_params_set_format(handle, hw_params, SND_PCM_FORMAT_S16_LE);
	snd_pcm_hw_params_set_channels(handle, hw_params, channels);
	snd_pcm_hw_params_set_rate_near(handle, hw_params, &rate, 0);
	snd_pcm_hw_params(handle, hw_params);

	snd_pcm_hw_params_get_period_size(hw_params, &frames, 0);

	buff_size = frames * channels * 2;
	buffer = (char *) malloc(buff_size);

	snd_pcm_hw_params_get_period_time(hw_params, &tmp, NULL);

	for (loops = (seconds * 1000000) / tmp; loops > 0; loops--) {

		if (pcm = read(0, buffer, buff_size) == 0) {
			printf("Early end of file.\n");
			return 0;
		}

		if (pcm = snd_pcm_writei(handle, buffer, frames) == -EPIPE) {
			printf("XRUN.\n");
			snd_pcm_prepare(handle);
		} else if (pcm < 0) {
			printf("ERROR. Can't write to PCM device. %s\n", snd_strerror(pcm));
		}

	}

	snd_pcm_drain(handle);
	snd_pcm_close(handle);
	free(buffer);

	return 0;
}
