cd /tmp;

mkfifo 200.json.in
mkfifo 200.json.out

systemctl start audio-conf
killall audio-netrecv

/usr/bin/audio-netsend 200.json
