cd /tmp;

systemctl stop audio*
./cap168 & 

./play168 < testTone.wav

sleep 10

./play168 < testTone2.wav


exit;
