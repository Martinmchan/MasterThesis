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

x116 = find(y116 > 0.1);
x38 = find(y38 > 0.1);

x116c1 = 42786;
x38c1 = 54036;

x116c2 = 103718;
x38c2 = 114261;