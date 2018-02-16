close all;
clear all;

[mic1,f] = audioread('cap168.wav');
[mic2,f] = audioread('cap38.wav');
[mic3,f] = audioread('cap99.wav');

s = 450001:600000;


plot(mic1)
figure
plot(mic2)
figure
plot(mic3)

tdoa12 = ourGccphat(mic1(s),mic2(s));
deltaS12 = (tdoa12/f*343);
tdoa13 = ourGccphat(mic1(s),mic3(s));
deltaS13 = (tdoa13/f*343);
tdoa23 = ourGccphat(mic2(s),mic3(s));
deltaS23 = (tdoa23/f*343);

disp("delta12 = " + deltaS12);
disp("delta13 = " + deltaS13);
disp("delta23 = " + deltaS23);
