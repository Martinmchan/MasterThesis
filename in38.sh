cd /tmp;

systemctl stop audio*
./play38 < testTone.wav & ./cap38

exit;
