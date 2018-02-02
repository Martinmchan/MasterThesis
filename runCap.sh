cat cap.sh | sshpass -p pass ssh root@172.25.9.116 &
cat cap.sh | sshpass -p pass ssh root@172.25.9.38 &


sshpass -p "pass" scp root@172.25.9.116:/tmp/cap.raw .;
sox -r 48000 -e signed-integer -b 16 -c 1 cap.raw  cap1Exp1.wav;
sshpass -p "pass" scp root@172.25.9.38:/tmp/cap.raw .;
sox -r 48000 -e signed-integer -b 16 -c 1 cap.raw  cap2Exp1.wav;





