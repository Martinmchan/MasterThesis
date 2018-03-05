close all;
clear all;

[mic1, f] = audioread('mic1.wav');
X = mic1(1119800:1120400);

Y = fft(X);
L = length(Y);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

P1 = P1(1:300);

Fs = 48000
f = Fs*(0:(L/2))/L;
f = f(1:300);

plot(f,P1)