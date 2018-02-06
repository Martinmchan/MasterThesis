cd /tmp;

systemctl stop audio*
./play99 < testTone.wav & ./cap99

exit;
