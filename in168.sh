cd /tmp;

systemctl stop audio*
arecord -Daudiosource -r48000 -fS16_LE -c1 -d30 /tmp/mic1.wav & 

sleep 2

aplay -Dlocalhw_0 -r48000 -fS16_LE /tmp/testTone.wav

exit;
