cd /tmp;

systemctl stop audio*
arecord -Daudiosource -r48000 -fS16_LE -c1 -d25 /tmp/mic3.wav & 

sleep 10

aplay -Dlocalhw_0 -r48000 -fS16_LE /tmp/testTone.wav

exit;
