close all;
clear all;
t = 1:1/48000:10;

[y,Fs] = audioread('cap38.wav');

Y = fft(y);

L = length(Y);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;


P1 = P1.*(P1>0.006);



y = real(ifft(P1));
 
plot(y)