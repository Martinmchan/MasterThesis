
close all
clear all
[mic1, f] = audioread('mic1_6.wav');
[mic2, f] = audioread('mic2_6.wav');



plot(mic1)
hold on
plot(mic2)

%%

s1 = 1:200000;
s2 = 200001:350000;
[syncedmic2, distance, deltaT] = ourSync(mic1, mic2, s1, s2);


