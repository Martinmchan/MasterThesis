systemctl stop audio*
arecord -Daudiosource -r 48000 -fS16_LE -c1 -d12 /tmp/cap172.25.13.200.wav &

sleep 5
aplay -Dlocalhw_0 -r 48000 -f S16_LE /tmp/testTone.wav

exit;
