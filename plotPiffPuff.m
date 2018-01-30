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

t_1a = 731145931;
t_2a = 736534346;

t_1b = 732156450;
t_2b = 735150142;

T = (cPC_a + cCP_b + t_1a + t_2b - t_1b - t_2a)/2;
deltaS = T*343/1000000