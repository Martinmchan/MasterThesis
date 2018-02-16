

close all
clear all

Fs = 48000;


t = 1:48000;
y = sin(3*2*pi*t/Fs);
y = y + sin(5*2*pi*t/Fs);



plot(y)

Y = fft(y);

L = length(Y);

P1 = abs(Y);
f = Fs*(0:L-1)/L;

% plot(f,P1)

Y(1:4) = 0;
Y(L-3:L) = 0;

y = ifft(Y);

figure
plot(real(y))

%sound(abs(y),48000)

