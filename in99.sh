cd /tmp;

systemctl stop audio*
arecord -Daudiosource -r48000 -fS16_LE -c1 -d15 /tmp/cap99.wav & 

sleep 6

aplay -Dlocalhw_0 -r48000 -fS16_LE /tmp/testTone.wav

exit;
