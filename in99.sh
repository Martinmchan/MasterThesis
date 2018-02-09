cd /tmp;

systemctl stop audio*
./cap99 & 
./play99 < testTone.wav

sleep 5

./play99 < testTone2.wav


exit;
