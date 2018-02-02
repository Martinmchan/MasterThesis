close all;
clear all;

[yPC, f] = audioread('PC.wav');
[yCP, f] = audioread('CP.wav');


plot(yPC);
figure;
plot(yCP);

xPC = find(yPC>0.008,1); 
xCP = find(yCP>0.008,1); 

cPC_a = xPC/f*1000000;
cCP_b = xCP/f*1000000;

file1 = fopen('PC.txt','r');
tPC = fscanf(file1,'%f');

file2 = fopen('CP.txt','r');
tCP = fscanf(file2, '%f');

delay = 1536;
T = (cPC_a + cCP_b + tCP(1) + tPC(2) - (tPC(1) +  delay/f*1000000) - (tCP(2) +  delay/f*1000000))/2;
deltaS = T*343/1000000