sshpass -p "pass" scp root@172.25.9.116:/tmp/piff.raw .
sshpass -p "pass" scp root@172.25.9.116:/tmp/piff.txt .

sshpass -p "pass" scp root@172.25.9.38:/tmp/puff.raw .
sshpass -p "pass" scp root@172.25.9.38:/tmp/puff.txt .

sox -r 48000 -e signed-integer -b 16 -c 1 piff.raw  piff.wav
sox -r 48000 -e signed-integer -b 16 -c 1 puff.raw  puff.wav
