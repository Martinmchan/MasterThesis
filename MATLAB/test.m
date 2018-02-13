close all;
clear all;

[y,f] = audioread('000129_240_mono1.wav');

plot(abs(y))
hold on

[xStart xEnd] = findSound(y);

plot(xStart, 0, 'go');
plot(xEnd, 0, 'ro');
