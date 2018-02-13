cd /tmp;

systemctl stop audio*
arecord -Daudiosource -r48000 -fS16_LE -c1 -d15 /tmp/cap168.wav & 

sleep 2

aplay -Dlocalhw_0 -r48000 -fS16_LE /tmp/testTone.wav

exit;
