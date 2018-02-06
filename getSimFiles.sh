sshpass -p "pass" scp root@172.25.12.99:/tmp/cap99.raw .
sshpass -p "pass" scp root@172.25.12.168:/tmp/cap168.raw .
sshpass -p "pass" scp root@172.25.9.38:/tmp/cap38.raw .

sox -r 48000 -e signed-integer -b 16 -c 1 cap168.raw  ~/MATLAB/MasterThesis/MATLAB/cap168.wav
sox -r 48000 -e signed-integer -b 16 -c 1 cap99.raw  ~/MATLAB/MasterThesis/MATLAB/cap99.wav
sox -r 48000 -e signed-integer -b 16 -c 1 cap38.raw  ~/MATLAB/MasterThesis/MATLAB/cap38.wav
