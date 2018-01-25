
cd /usr/local//mipsisa32r2el/r28/bin;
./mipsisa32r2el-axis-linux-gnu-gcc ~/MATLAB/MasterThesis/miniCap.c -I/usr/include -o ~/MATLAB/MasterThesis/alsa_recording -L/home/martinch/alsa -lasound;


cd /home/martinch/MATLAB/MasterThesis;
sshpass -p "pass" scp alsa_recording root@172.25.9.116:/tmp

cat recordRaw.sh | sshpass -p pass ssh root@172.25.9.116



sshpass -p "pass" scp root@172.25.9.116:/tmp/test.raw .
sshpass -p "pass" scp root@172.25.9.116:/tmp/timeStamps.txt .


sox -r 48000 -e signed-integer -b 16 -c 1 test.raw  test.wav
sshpass -p "pass" scp test.wav root@172.25.9.116:/tmp

cat playWav.sh | sshpass -p pass ssh root@172.25.9.116


