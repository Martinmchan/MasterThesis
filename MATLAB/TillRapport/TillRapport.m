
close all
clear all

[mic1, f] = audioread('cap172.25.9.38.wav');
[mic2, f] = audioread('cap172.25.13.200.wav');



plot(mic1)
hold on
plot(mic2)


s1 = 1:200000;
s2 = 200001:400000;


[syncedmic2, dist, deltaT] = ourSync(mic1, mic2, s1, s2);

figure
plot(mic1)
hold on
plot(syncedmic2)
