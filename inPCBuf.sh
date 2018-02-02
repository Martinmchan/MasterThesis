cd /tmp;

systemctl stop audio*
./playCapBuf < testTone.wav;

exit;
