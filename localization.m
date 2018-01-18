clear all

[y1, Fs1] = audioread('000101_257_mono1.wav');
[y2, Fs2] = audioread('000101_257_mono2.wav');
[y3, Fs3] = audioread('000101_257_mono3.wav');

[sz, ~] = size(y1);
treshold = max(y1)/3;
tresholdValue = find(y1 >= treshold);
start = tresholdValue(1) - floor(sz/200);
finish = start + floor(sz/30);

suby1 = y1(start:finish);
suby2 = y2(start:finish);
suby3 = y3(start:finish);

x1 = fft(suby1);
x2 = fft(suby2);
x3 = fft(suby3);

L = finish-start;

gPhat12 = x1.*x2/(x1'*x2);
gPhat23 = x2.*x3/(x2'*x3);
gPhat31 = x3.*x1/(x3'*x1);


r12 = ifft(gPhat12);
r23 = ifft(gPhat23);
r31 = ifft(gPhat31);

[~, argM12] = max(r12(1:floor(L/2)));
[~, argM23] = max(r23(1:floor(L/2)));
[~, argM31] = max(r31(1:floor(L/2)));
tdoa12 = argM12/(L*Fs1)
tdoa23 = argM23/(L*Fs1)
tdoa31 = argM31/(L*Fs1)


