systemctl stop audio*
arecord -Daudiosource -r 48000 -fS16_LE -c1 -d12 /tmp/cap172.25.9.38.wav &

sleep 2
aplay -Dlocalhw_0 -r 48000 -f S16_LE /tmp/testTone.wav

exit;
