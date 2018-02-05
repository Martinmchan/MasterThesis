cd /tmp;

systemctl stop audio*
./play168 < testTone.wav & ./cap

exit;
