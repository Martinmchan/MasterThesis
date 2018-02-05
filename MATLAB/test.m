clear all
close all
[y168, f] = audioread('sim168.wav');
[y99, f] = audioread('sim99.wav');

plot(y168)
figure
plot(y99)

t168 = 746998599;
t99 =  747088871;



x168 = find(y168>0.01); 
x99 = find(y99>0.01); 

x168a = 96959/f*1000000 + t168;
x168b = 293350/f*1000000 + t168;

x99a = 92420/f*1000000 + t99;
x99b = 288554/f*1000000 + t99;

T = (x99a + x168b - x168a - x99b)/2/1000000
;
deltaS = 343*T


