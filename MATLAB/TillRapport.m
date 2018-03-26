
close all
clear all
[mic1, f] = audioread('mic1_0326_10.wav');
[mic2, f] = audioread('mic2_0326_10.wav');

s = 320001:490000;

plot(mic1)
hold on
plot(mic2)

[syncedmic2, distance, ~] = ourSync(mic1, mic2, 1:200000, 200001:400000);

figure
plot(mic1)
hold on
plot(syncedmic2)

tdoa1 = ourMovingAverage(mic1(s), mic2(s))/f*343;
tdoa2 = ourMovingAverage(mic1(s), syncedmic2(s))/f*343;