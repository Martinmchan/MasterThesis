clear all
[y1, Fs1] = audioread('tascam116.wav');
[y3, Fs3] = audioread('tascam38.wav');


[sz, ~] = size(y1);
treshold = max(y3);
tresholdValue = find(y3 >= treshold);


start = tresholdValue(1) - floor(sz/200);
finish = tresholdValue(1) + floor(sz/50);

suby1 = y1(start:finish);
suby3 = y3(start+409:finish);

figure
plot(suby1)
hold on
plot(suby3)

corre = xcorr(suby1, suby3);

[C I] = max(corre);

tdoa= ((length(corre)+1)/2 - I)

tdoa = tdoa/Fs1;

deltaS = tdoa*343