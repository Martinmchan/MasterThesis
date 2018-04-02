sshpass -p "pass" ~/MATLAB/MasterThesis/ArvidoDannys/200.json &
sshpass -p "pass" ~/MATLAB/MasterThesis/ArvidoDannys/200.json &

sleep 5

cat in200.sh | sshpass -p pass ssh root@172.25.13.200 &
cat in38.sh | sshpass -p pass ssh root@172.25.13.38 &

