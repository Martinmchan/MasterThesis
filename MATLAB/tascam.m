%285x285x170
%Test 0 - klapp vid mic 1
%Test 1 - prat vid mic 1
%Test 2 - klapp mellan mic2 och mic 4
%Test 3 - musik vid mic 3
%Test 4 - musik mellan mic 1 och mic 2
%Test 5 - musik mellan mic 3 och mic 4 p? golvet
%Test 6 - musik mellan mic 1 och mic 3 
%Test 7 - musik vid dockan
%---------------------------------------
%285x520x170
%Test 8 - musik vid 4 5.2 meter
%Test 9 - musik vid 3 p? golvet 5.2 meter


clear all
close all

[mic1, f] = audioread('000224_242_mono1.wav');
[mic2, f] = audioread('000224_242_mono2.wav');
[mic3, f] = audioread('000224_242_mono3.wav');
[mic4, f] = audioread('000224_242_mono4.wav');



mic1 = ourFilter(mic1,1,100);
mic2 = ourFilter(mic2,1,100);
mic3 = ourFilter(mic3,1,100);
mic4 = ourFilter(mic4,1,100);


% 
% s = 1:120000;
% mic1 = mic1(s);
% mic2 = mic2(s);
% mic3 = mic3(s);
% mic4 = mic4(s);

cameraMatrix = [0 0 1.70; 0 1.80 1.70; 1.57 0 1.70; 1.57 1.80 1.70];
lsb = [-1,-1,0];
usb = [max(cameraMatrix(:,1)) + 1,max(cameraMatrix(:,2)) + 1,3];

[xS, yS, zS] = LM(mic1, mic2, mic3, mic4, cameraMatrix, lsb, usb);

scatterPlot(cameraMatrix, xS, yS, zS, lsb, usb);


%%
clear all
close all

[mic1, f] = audioread('000225_243_mono1.wav');
[mic2, f] = audioread('000225_243_mono2.wav');
[mic3, f] = audioread('000225_243_mono3.wav');
[mic4, f] = audioread('000225_243_mono4.wav');
% 
% s = 70000:1660000;
% mic1 = mic1(s);
% mic2 = mic2(s);
% mic3 = mic3(s);
% mic4 = mic4(s);




cameraMatrix = [0 0 1.55; 0 2.85 1.55; 2.85 0 1.55; 2.85 2.85 1.55];
lsb = [-1,-1,0];
usb = [max(cameraMatrix(:,1)) + 1,max(cameraMatrix(:,2)) + 1,3];
sz = length(mic1);
window = 2000;
gccMap = [];

for i = 1:window:sz-window
    [xS, yS, zS] = LM(mic1(i:i+window), mic2(i:i+window), mic3(i:i+window), mic4(i:i+window), cameraMatrix, lsb, usb);
    gccMap = [gccMap [xS yS zS]'];
end

scatterPlot(cameraMatrix, gccMap(1,1),gccMap(2,1),gccMap(3,1), lsb, usb);
nbrOfPoints = length(gccMap(1,:)); 
for i = 2:nbrOfPoints
    scatter3(gccMap(1,i),gccMap(2,i),gccMap(3,i),'*b','MarkerFaceColor','g')
end

