clear all
close all

[y1, Fs1] = audioread('000102_263_mono1.wav');
[y3, Fs3] = audioread('000102_263_mono3.wav');

[sz, ~] = size(y1);
treshold = max(y1)/3;
tresholdValue = find(y1 >= treshold);


start = tresholdValue(1) - floor(sz/30);
finish = tresholdValue(1) + floor(sz/30);

suby1 = y1(start:finish);
suby3 = y3(start:finish);

x1 = fft(suby1);
x3 = fft(suby3);

L = finish-start;

gPhat31 = x3.*conj(x1)/(x3'*conj(x1));

r31 = ifft(gPhat31);

[~, argM31] = max(r31);

tdoa31 = argM31/Fs1/L*2*pi

deltaS = tdoa31*343


