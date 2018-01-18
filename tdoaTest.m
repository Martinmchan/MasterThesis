clear all
close all

[y1, Fs1] = audioread('000102_270_mono1.wav');
[y3, Fs3] = audioread('000102_270_mono3.wav');


[sz, ~] = size(y1);
treshold = max(y3);
tresholdValue = find(y3 >= treshold);


start = tresholdValue(1) - floor(sz/200);
finish = tresholdValue(1) + floor(sz/50);

suby1 = y1(start:finish);
suby3 = y3(start:finish);
grid on
plot(suby3)
hold on
plot(suby1)

x1 = fft(suby1);
x3 = fft(suby3);

L = finish-start;

gPhat31 = x3.*conj(x1)/norm((x3'*conj(x1)));

r31 = ifft(gPhat31);

[~, argM31] = max(r31);

tdoa31 = ((L+1)/2 - argM31)/Fs1

deltaS = tdoa31*343


