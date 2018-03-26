#sshpass -p "pass" scp root@172.25.45.152:/tmp/mic1.wav ~/MATLAB/MasterThesis/MATLAB/NCS
#sshpass -p "pass" scp root@172.25.45.141:/tmp/mic2.wav ~/MATLAB/MasterThesis/MATLAB/NCS
#sshpass -p "pass" scp root@172.25.45.245:/tmp/mic3.wav ~/MATLAB/MasterThesis/MATLAB/NCS
#sshpass -p "pass" scp root@172.25.45.220:/tmp/mic4.wav ~/MATLAB/MasterThesis/MATLAB/NCS
#sshpass -p "pass" scp root@172.25.45.222:/tmp/mic5.wav ~/MATLAB/MasterThesis/MATLAB/NCS
#sshpass -p "pass" scp root@172.25.45.134:/tmp/mic6.wav ~/MATLAB/MasterThesis/MATLAB/NCS
#sshpass -p "pass" scp root@172.25.45.70:/tmp/mic7.wav ~/MATLAB/MasterThesis/MATLAB/NCS
#sshpass -p "pass" scp root@172.25.45.157:/tmp/mic8.wav ~/MATLAB/MasterThesis/MATLAB/NCS

#sox -r 48000 -e signed-integer -b 16 -c 1 cap168.raw  ~/MATLAB/MasterThesis/MATLAB/cap168.wav
#sox -r 48000 -e signed-integer -b 16 -c 1 cap99.raw  ~/MATLAB/MasterThesis/MATLAB/cap99.wav
#sox -r 48000 -e signed-integer -b 16 -c 1 cap38.raw  ~/MATLAB/MasterThesis/MATLAB/cap38.wav

mv ~/Documents/GoertzelLocalization/deprecated/DistanceCalculation/bin/recordings/cap172.25.9.38.wav ~/MATLAB/MasterThesis/MATLAB/NCS/mic1.wav 
mv ~/Documents/GoertzelLocalization/deprecated/DistanceCalculation/bin/recordings/cap172.25.13.200.wav ~/MATLAB/MasterThesis/MATLAB/NCS/mic2.wav 

