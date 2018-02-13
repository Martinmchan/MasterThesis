close all;
clear all;

[y1,f] = audioread('000128_240_mono1.wav');
[y2, f] = audioread('000128_240_mono2.wav');


y1 = [zeros(100,1); y1];
y2zeros = [y2; zeros(100,1)];
y2 = [zeros(100,1); y2];
size = length(y1)

plot(y2)
hold on
plot(y1)
figure


y2Synced = ourSync(y1,y2zeros,1:110000, 110001:220000);


plot(y2(1:200000) - y2Synced(1:200000));
