%Test 0 - klapp vid mic 1
%Test 1 - prat vid mic 1
%Test 2 - klapp mellan mic2 och mic 4
%Test 3 - musik vid mic 3
%Test 4 - musik mellan mic 1 och mic 2
%Test 5 - musik mellan mic 3 och mic 4 p? golvet
%Test 6 - musik mellan mic 1 och mic 3 
%Test 7 - musik vid dockan
%---------------------------------------
%Test 8 - musik vid 4 5.2 meter
%Test 9 - musik vid 3 p? golvet 5.2 meter


clear all
close all

[mic1, f] = audioread('000224_240_mono1.wav');
[mic2, f] = audioread('000224_240_mono2.wav');
[mic3, f] = audioread('000224_240_mono3.wav');
[mic4, f] = audioread('000224_240_mono4.wav');

plot(mic4)


s = 1:120000;
mic1 = mic1(s);
mic2 = mic2(s);
mic3 = mic3(s);
mic4 = mic4(s);

cameraMatrix = [0 0 1.1; 0 1.8 1.1; 1.57 0 1.1; 1.57 1.80 1.1];
lsb = [-1,-1,0];
usb = [max(cameraMatrix(:,1)) + 1,max(cameraMatrix(:,2)) + 1,3];

[xS, yS, zS] = LM(mic1, mic2, mic3, mic4, cameraMatrix, lsb, usb);

scatterPlot(cameraMatrix, xS, yS, zS, lsb, usb);



