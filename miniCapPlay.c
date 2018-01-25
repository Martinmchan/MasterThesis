// MiniCapPlay
// audiosource localhw0 test.wav

#include <stdio.h>
#include <stdlib.h>
#include <alsa/asoundlib.h>

	      
main (int argc, char *argv[])
{
	char *buffer;
	int buffer_frames = 128;
	signed int rate = 48000;
	snd_pcm_t *handle;
	snd_pcm_hw_params_t *hw_params;
	snd_pcm_uframes_t frames;
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
	FILE *fp = fopen("test.raw", "w");
  	FILE *timeFile = fopen("timeStamps.txt", "w");
  	
	//Get timestamp
	struct timeval timer_usec; 
	long long int timestamp_usec;
	timestamp_usec = ((long long int) timer_usec.tv_sec) * 1000000ll + 
	        (long long int) timer_usec.tv_usec;
  	fprintf(timeFile, "%lld \n", timestamp_usec);
  	fclose(timeFile);

	//Start recording
	for (i = 0; i < 1000; ++i) {
    		snd_pcm_readi(handle, buffer, buffer_frames);
    		fwrite(buffer, sizeof(buffer[0]), 256, fp);	
	}

  	free(buffer);
  	fclose(fp);
	
  	snd_pcm_close (handle);
	exit (0);
	

}
