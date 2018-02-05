clear all;
close all;
[y116, f] = audioread('cap116.wav');
[y38, f] = audioread('cap38.wav');

plot(y116);
figure
plot(y38);
figure
plot(y116,'r');
hold on
plot(y38);

x1 = 1:200000;
x2 = 200001:400000;

y1161 = y116(x1);
y381 = y38(x1);
y1162 = y116(x2);
y382 = y38(x2);



corre1 = xcorr(y1161, y381);
[C I1] = max(corre1);
tdoa1 = ((length(corre1)+1)/2 - I1)

corre2 = xcorr(y1162, y382);
[C I2] = max(corre2);
tdoa2 = ((length(corre2)+1)/2 - I2)

tdoa = (tdoa2 - tdoa1)/2;
tdoa = tdoa/f;
deltaS = 343*tdoa







