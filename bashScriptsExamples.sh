amixer -c1 scontrols
amixer -c1 sget 'Headphone'
amixer -c1 sset 'Headphone' 40


amixer -c1 controls
amixer -c1 cset numid=263 50
amixer -c1 cget numid=263

ffmpeg -f s16le -ar 48k -ac 4 -i test.raw test.wav
ffmpeg -i test.wav -map_channel 0.0.0 test1.wav -map_channel 0.0.1 test2.wav -map_channel 0.0.2 test3.wav -map_channel 0.0.3 test4.wav


