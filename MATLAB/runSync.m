close all;
clear all;

[mic1, f] = audioread('cap168.wav');
[mic2, f] = audioread('cap99.wav');
[mic3, f] = audioread('cap38.wav');

plot(mic1)
hold on
plot(mic2)
plot(mic3)
figure

mic1 = mic1 - mean(mic1);
mic2 = mic2 - mean(mic2);
mic3 = mic3 - mean(mic3);

s1 = 1:200000;
s2 = 200001:400000;
s3 = 400001:600000;

mic2 = ourSync(mic1, mic2, s1, s2);
mic3 = ourSync(mic1, mic3, s1, s3);


plot(mic1)
hold on
plot(mic2)
plot(mic3)




tdoa12 = ourGccphat(mic1(s3),mic2(s3));
deltaS12 = abs(tdoa12/f*343);
tdoa13 = ourGccphat(mic1(s2),mic3(s2));
deltaS13 = abs(tdoa13/f*343);
tdoa23 = ourGccphat(mic2(s1),mic3(s1));
deltaS23 = abs(tdoa23/f*343);



disp("delta12 = " + deltaS12);
disp("delta13 = " + deltaS13);
disp("delta23 = " + deltaS23);




