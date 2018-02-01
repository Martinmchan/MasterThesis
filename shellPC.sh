aplay -Dplughw:1,0,0 testTone.wav &

arecord -Daudiosource -r48000 -fS16_LE -c1 shellPC.wav &
