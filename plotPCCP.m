close all;
clear all;

[yPC, f] = audioread('PC.wav');
[yCP, f] = audioread('CP.wav');


plot(yPC);
figure;
plot(yCP);

xPC = find(yPC>0.01,1); 
xCP = find(yCP>0.01,1); 

cPC_a = xPC/f*1000000;
cCP_b = xCP/f*1000000;

file1 = fopen('PC.txt','r');
t1 = fscanf(file1,'%f');

file2 = fopen('CP.txt','r');
t2 = fscanf(file2, '%f');

T = (cPC_a + cCP_b + t2(1) + t1(2) - t1(1) - t2(2))/2;
deltaS = T*343/1000000