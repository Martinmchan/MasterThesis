#include <stdio.h>
#include <stdlib.h>
#include <alsa/asoundlib.h>
#include <unistd.h>
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
	seconds  = 1;

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
	
	sleep(1);	
	
	FILE *timeFile = fopen("puff.txt", "a");
  	struct timeval currentTimeP;
  	gettimeofday(&currentTimeP, NULL);

	for (loops = (seconds * 1000000) / tmp; loops > 0; loops--) {
		read(0, buff, buff_size);
		snd_pcm_writei(pcm_handle, buff, frames);
	}

	snd_pcm_drain(pcm_handle);
	snd_pcm_close(pcm_handle);
	free(buff);
	
	sleep(2);
	
	////START RECORD!
	char *buffer;
	int buffer_frames = 128;
	snd_pcm_t *handle;
	snd_pcm_hw_params_t *hw_params;
	snd_pcm_format_t format = SND_PCM_FORMAT_S16_LE;

	snd_pcm_open(&handle, argv[1], SND_PCM_STREAM_CAPTURE, 0);
	snd_pcm_hw_params_malloc(&hw_params);
	snd_pcm_hw_params_any(handle, hw_params);
	snd_pcm_hw_params_set_access(handle, hw_params, SND_PCM_ACCESS_RW_INTERLEAVED);
	snd_pcm_hw_params_set_format(handle, hw_params, format);
	snd_pcm_hw_params_set_rate_near(handle, hw_params, &rate, 0);
	snd_pcm_hw_params_set_channels(handle, hw_params, 1); // Changed from 2 to 1
	snd_pcm_hw_params (handle, hw_params);
	snd_pcm_prepare (handle);
	
	buffer = malloc(128 * snd_pcm_format_width(format) / 8 * 2);
	int i;
	int j;
	FILE *fp = fopen("puff.raw", "w");
  	
	//Get timestamp
	struct timeval currentTimeC;
	gettimeofday(&currentTimeC, NULL);
	
	//Start recording
	for (i = 0; i < 2000; ++i) {
    		snd_pcm_readi(handle, buffer, buffer_frames);
    		fwrite(buffer, sizeof(buffer[0]), 256, fp);	
	}
	
	//Write the times on file
	long long int timeStampP = currentTimeP.tv_sec * (int)1e6 + currentTimeP.tv_usec;
	fprintf(timeFile, "%lld \n", timeStampP);
	long long int timeStampC = currentTimeC.tv_sec * (int)1e6 + currentTimeC.tv_usec;
	fprintf(timeFile, "%lld \n \n", timeStampC);
	fclose(timeFile);

  	free(buffer);
  	fclose(fp);
	
  	snd_pcm_close (handle);

	
	return 0;
}
