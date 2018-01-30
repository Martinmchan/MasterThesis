
cd /usr/local//mipsisa32r2el/r28/bin;
./mipsisa32r2el-axis-linux-gnu-gcc ~/MATLAB/MasterThesis/capPlay.c -I/usr/include -o ~/MATLAB/MasterThesis/capPlay -L/home/martinch/alsa -lasound;

./mipsisa32r2el-axis-linux-gnu-gcc ~/MATLAB/MasterThesis/playCap.c -I/usr/include -o ~/MATLAB/MasterThesis/playCap -L/home/martinch/alsa -lasound;

cd /home/martinch/MATLAB/MasterThesis;
sshpass -p "pass" scp capPlay root@172.25.9.116:/tmp;
sshpass -p "pass" scp playCap root@172.25.9.38:/tmp

