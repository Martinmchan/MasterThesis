close all;
clear all;

[X,Fs] = audioread('testTone.wav');

Y = fft(X);
L = length(Y);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

P1 = P1(1:1000);


f = Fs*(0:(L/2))/L;
f = f(1:1000);

plot(f,P1)