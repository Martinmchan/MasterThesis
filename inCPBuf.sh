cd /tmp;

systemctl stop audio*
./capPlayBuf < testTone.wav;

exit;
