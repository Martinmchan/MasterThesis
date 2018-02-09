cd /tmp;

systemctl stop audio*
 ./cap38 & 

./play38 < testTone.wav

sleep 2

./play38 < testTone2.wav


exit;
