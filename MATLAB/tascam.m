%Test 1 - klapp vid mic 1
%Test 2 - prat vid mic 1
%Test 3 - klapp mellan mic2 och mic 4
%Test 4 - musik vid mic 3
%Test 5 - musik mellan mic 1 och mic 2
%Test 6 - musik mellan mic 3 och mic 4 p? golvet
%Test 7 - musik mellan mic 1 och mic 3 
%Test 8 - musik vid dockan
%---------------------------------------
%Test 9 - musik vid 4 5.2 meter
%Test 10 - musik vid 3 p? golvet 5.2 meter


clear all
close all

[mic1, f] = audioread('000219_248_mono1.wav');
[mic2, f] = audioread('000219_248_mono2.wav');
[mic3, f] = audioread('000219_248_mono3.wav');
[mic4, f] = audioread('000219_248_mono4.wav');

plot(mic4)

% 
% s = 46000:75000;
% mic1 = mic1(s);
% mic2 = mic2(s);
% mic3 = mic3(s);
% mic4 = mic4(s);

cameraMatrix = [0 0 1.7; 0 5.2 1.7; 2.85 0 1.7; 2.85 5.2 1.7]; %; 1.2 1.65 0.1];
lsb = [-1,-1,0];
usb = [max(cameraMatrix(:,1)) + 1,max(cameraMatrix(:,2)) + 1,3];

[xS, yS, zS] = LM(mic1, mic2, mic3, mic4, cameraMatrix, lsb, usb);
[finalpos,finalsrp,finalfe]=srplems([mic1 mic2 mic3 mic4], cameraMatrix, f, lsb, usb);

xSRP = finalpos(1,1); ySRP = finalpos(1,2); zSRP = finalpos(1,3);
scatterPlot(cameraMatrix, xS, yS, zS, lsb, usb);
hold on
scatter3(finalpos(1,1),finalpos(1,2),finalpos(1,3),'*g','MarkerFaceColor','g')


