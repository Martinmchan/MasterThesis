cd /tmp;

systemctl stop audio*
arecord -Daudiosource -r48000 -fS16_LE -c1 -d40 /tmp/mic4.wav & 

sleep 14

aplay -Dlocalhw_0 -r48000 -fS16_LE /tmp/testTone.wav

exit;
