clear all

[y1, Fs1] = audioread('000102_262_mono1.wav');


[sz, ~] = size(y1);
treshold = max(y1)/3;
tresholdValue = find(y1 >= treshold);
start = tresholdValue(1) - floor(sz/200);
finish = start + floor(sz/30);

suby1 = y1(start:finish);

x1 = fft(suby1);
invX1 = ifft(x1);

plot(suby1)
hold on
plot(invX1,'o')

