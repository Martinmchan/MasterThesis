
close all
clear all
[mic1, f] = audioread('mic1_0329_10.wav');
[mic2, f] = audioread('mic2_0329_10.wav');



plot(mic1)
hold on
plot(mic2)


tdoa = ourMovingAverage(mic1,mic2)/f*343