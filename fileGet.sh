sshpass -p "pass" scp root@172.25.9.116:/tmp/CP.raw .
sshpass -p "pass" scp root@172.25.9.116:/tmp/CP.txt .

sshpass -p "pass" scp root@172.25.9.38:/tmp/PC.raw .
sshpass -p "pass" scp root@172.25.9.38:/tmp/PC.txt .

sox -r 48000 -e signed-integer -b 16 -c 1 CP.raw  CP.wav
sox -r 48000 -e signed-integer -b 16 -c 1 PC.raw  PC.wav
