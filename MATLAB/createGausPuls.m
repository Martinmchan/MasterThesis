close all;
clear all;

Fs = 48000;
t = 1:48000;

normford1 = 50*normpdf(t,12000,2);
normford2 = 50*normpdf(t,24000,2);
normford3 = 50*normpdf(t,36000,2);

normford = normford1 + normford2 + normford3;


plot(normford)

Y = fft(normford);

L = length(Y);

P1 = abs(Y);
f = Fs*(0:L-1)/L;

% plot(f,P1)

Y(1:2500) = 0;
Y(L-19000:L) = 0;

y = ifft(Y);

figure
plot(real(y))

%sound(normford, 48000)
sound(real(y), 48000);
audiowrite('gaussToneFilter.wav',real(y),48000)