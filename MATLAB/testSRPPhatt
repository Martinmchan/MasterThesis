close all
clear all
mic_loc = [0 0 1.7; -0.1 2.7 1.7; 2.2 0.5 1.68; 2.1 2.7 1.85];
[mic1, f] = audioread('mic1test19.wav');
[mic2, f] = audioread('mic2test19.wav');
[mic3, f] = audioread('mic3test19.wav');
[mic4, f] = audioread('mic4test19.wav');

mic1 = mic1 - mean(mic1);
mic2 = mic2 - mean(mic2);
mic3 = mic3 - mean(mic3);
mic4 = mic4 - mean(mic4);

plot(mic1)
hold on
plot(mic2)
plot(mic3)
plot(mic4)


%Syncs all the microphones using mic1 as master, then plot the result.
%Distance between the microphones are also shown as an indicator of how
%good the sync was.
s1 = 1:200000;
s2 = 200001:400000;
s3 = 400001:600000;
s4 = 600001:800000;

[mic2, dist12, ~] = ourSync2(mic1, mic2, s1, s2);
[mic3, dist13, ~] = ourSync2(mic1, mic3, s1, s3);
[mic4, dist14, ~] = ourSync2(mic1, mic4, s1, s4);

syncQuality1 = checkSync(mic_loc, dist12, dist13, dist14);
syncQuality2 = checkSync2(mic2, mic3, s2, s3);
syncQuality3 = checkSync2(mic3, mic4, s3, s4);

figure
plot(mic1)
hold on
plot(mic2)
plot(mic3)
plot(mic4)



%Generate the data after sync
mic1 = mic1(800001:end);
mic2 = mic2(800001:end);
mic3 = mic3(800001:end);
mic4 = mic4(800001:end);


figure
plot(mic1)
hold on
plot(mic2)
plot(mic3)
plot(mic4)




fs = 48000;
lsb = [-1,-1,0];
usb = [3,3,3];
l = 1:350000;
s = [mic1(l) mic2(l) mic3(l) mic4(l)];
[finalpos,finalsrp,finalfe]=srplems(s, mic_loc, fs, lsb, usb)

scatterPlot(mic_loc, finalpos(1,1), finalpos(1,2), finalpos(1,3));


