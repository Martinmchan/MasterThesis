clear all
close all

[mic1, f] = audioread('000217_240_mono1.wav');
[mic2, f] = audioread('000217_240_mono2.wav');
[mic3, f] = audioread('000217_240_mono3.wav');
[mic4, f] = audioread('000217_240_mono4.wav');

cameraMatrix = [0 0 1.7; -0.1 2.7 1.7; 2.2 0.5 1.68; 2.1 2.7 1.85]; %; 1.2 1.65 0.1];

[xS, yS, zS] = LM(mic1, mic2, mic3, mic4, cameraMatrix);

lsb = [-1,-1,0];
usb = [3,3,3];
[finalpos,finalsrp,finalfe]=srplems([mic1 mic2 mic3 mic4], cameraMatrix, f, lsb, usb);

xSRP = finalpos(1,1); ySRP = finalpos(1,2); zSRP = finalpos(1,3);
scatterPlot(cameraMatrix, xS, yS, zS);
hold on
scatter3(finalpos(1,1),finalpos(1,2),finalpos(1,3),'*g','MarkerFaceColor','g')


