close all;
clear all;
tic
%Initialize camera position
cameraMatrix = [0 0 1.7; -0.1 2.7 1.7; 2.2 0.5 1.68; 2.1 2.7 1.85];
lsb = [-1,-1,0];
usb = [max(cameraMatrix(:,1)) + 1,max(cameraMatrix(:,2)) + 1,3];

%Reads the data and plots them
[mic1, f] = audioread('mic1test1.wav');
[mic2, f] = audioread('mic2test1.wav');
[mic3, f] = audioread('mic3test1.wav');
[mic4, f] = audioread('mic4test1.wav');

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


figure
plot(mic1)
hold on
plot(mic2)
plot(mic3)
plot(mic4)


syncQuality1 = checkSync(cameraMatrix, dist12, dist13, dist14);
syncQuality2 = checkSync2(mic2, mic3, s2, s3);
syncQuality3 = checkSync2(mic3, mic4, s3, s4);


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

%%

s = 80000:90000;
%Calculates the sound source position
[xS, yS, zS] = LM(mic1(s), mic2(s), mic3(s), mic4(s), cameraMatrix, lsb, usb);

[finalpos,finalsrp,finalfe]=srplems([mic1(s) mic2(s) mic3(s) mic4(s)], cameraMatrix, f, lsb, usb);

xSRP = finalpos(1,1); ySRP = finalpos(1,2); zSRP = finalpos(1,3);
scatterPlot(cameraMatrix, xS, yS, zS, lsb, usb);
hold on
scatter3(finalpos(1,1),finalpos(1,2),finalpos(1,3),'*g','MarkerFaceColor','g');
toc





























