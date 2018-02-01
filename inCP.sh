cd /tmp;

systemctl stop audio*
./capPlay < /dev/urandom;

exit;
