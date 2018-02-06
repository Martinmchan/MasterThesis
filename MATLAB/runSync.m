close all;
clear all;

[mic1, Fs1] = audioread('cap99.wav');
[mic2, Fs2] = audioread('cap168.wav');

plot(mic1)
hold on
plot(mic2)

figure


mic1 = mic1 - mean(mic1);
mic2 = mic2 - mean(mic2);

mic2 = ourSync(mic1, mic2);

plot(mic1)
hold on
plot(mic2)

x = 520000:640000;

tdoa = ourGccphat(mic1(x),mic2(x));
deltaS = tdoa/Fs1*343