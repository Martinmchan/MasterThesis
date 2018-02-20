sshpass -p "pass" scp root@172.25.12.99:/tmp/cap99.wav ~/MATLAB/MasterThesis/MATLAB/
sshpass -p "pass" scp root@172.25.12.168:/tmp/cap168.wav ~/MATLAB/MasterThesis/MATLAB/
sshpass -p "pass" scp root@172.25.9.38:/tmp/cap38.wav ~/MATLAB/MasterThesis/MATLAB/
sshpass -p "pass" scp root@172.25.13.250:/tmp/cap250.wav ~/MATLAB/MasterThesis/MATLAB/

#sox -r 48000 -e signed-integer -b 16 -c 1 cap168.raw  ~/MATLAB/MasterThesis/MATLAB/cap168.wav
#sox -r 48000 -e signed-integer -b 16 -c 1 cap99.raw  ~/MATLAB/MasterThesis/MATLAB/cap99.wav
#sox -r 48000 -e signed-integer -b 16 -c 1 cap38.raw  ~/MATLAB/MasterThesis/MATLAB/cap38.wav
