cd /tmp;

systemctl stop audio*
arecord -Daudiosource -r48000 -fS16_LE -c1 -d120 /tmp/mic8.wav & 

sleep 30

aplay -Dlocalhw_0 -r48000 -fS16_LE /tmp/testTone.wav

exit;
