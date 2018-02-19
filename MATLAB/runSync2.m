close all;
clear all;

[mic1, f] = audioread('cap168.wav');
[mic2, f] = audioread('cap99.wav');
[mic3, f] = audioread('cap38.wav');

plot(mic1)
figure
plot(mic2)
figure
plot(mic3)

s1 = 1:200000;
s2 = 200001:400000;
s3 = 400001:600000;

deltaS12 = ourSync2(mic1, mic2, s1, s2);
deltaS13 = ourSync2(mic1, mic3, s1, s3);
deltaS23 = ourSync2(mic2, mic3, s2, s3);
disp("delta12 = " + deltaS12);
disp("delta13 = " + deltaS13);
disp("delta23 = " + deltaS23);

