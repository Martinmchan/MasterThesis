close all;
clear all;

[mic1, f] = audioread('cap168.wav');
[mic2, f] = audioread('cap99.wav');
[mic3, f] = audioread('cap38.wav');
[mic4, f] = audioread('.wav');

mic1 = mic1 - mean(mic1);
mic2 = mic2 - mean(mic2);
mic3 = mic3 - mean(mic3);
mic4 = mic4 - mean(mic4);

plot(mic1)
figure
plot(mic2)
figure
plot(mic3)
plot(mic4)

s1 = 1:200000;
s2 = 200001:400000;
s3 = 400001:600000;
s4 = 600001:800000;

mic2 = ourSync2(mic1, mic2, s1, s2);
mic3 = ourSync2(mic1, mic3, s1, s3);
mic4 = ourSync2(mic1, mic4, s1, s4);

figure
plot(mic1)
hold on
plot(mic2)
plot(mic3)
plot(mic4)

s5 = 550000:700000;

tdoa12 = ourGccphat(mic1(s5),mic2(s5));
deltaS12 = abs(tdoa12/f*343);
tdoa13 = ourGccphat(mic1(s5),mic3(s5));
deltaS13 = abs(tdoa13/f*343);
tdoa23 = ourGccphat(mic2(s5),mic3(s5));
deltaS23 = abs(tdoa23/f*343);

disp("delta12 = " + deltaS12);
disp("delta13 = " + deltaS13);
disp("delta23 = " + deltaS23);



