
close all
clear all
<<<<<<< HEAD
[mic1, f] = audioread('cap172.25.9.38.wav');
[mic2, f] = audioread('cap172.25.13.200.wav');
=======
[mic1, f] = audioread('mic1_0329_10.wav');
[mic2, f] = audioread('mic2_0329_10.wav');
>>>>>>> be865fa19373327c71ac914aa076a081ed8f0d31



plot(mic1)
hold on
plot(mic2)


<<<<<<< HEAD
s1 = 1:200000;
s2 = 200001:400000;


[syncedmic2, dist, deltaT] = ourSync(mic1, mic2, s1, s2);

figure
plot(mic1)
hold on
plot(syncedmic2)
=======
tdoa = ourMovingAverage(mic1,mic2)/f*343
>>>>>>> be865fa19373327c71ac914aa076a081ed8f0d31
