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
%---------------------------------------
%157x180x170
%24_240: G-dragon vid mic 1
%24_241: Spice girls fr?n mic 1 till mic 2 och tillbaks
%24_242: The Sounds vid mic 1
%-----------------------------------------
%285x285x155
%24_243: Britney Spears vid mic 1
%24_244: Lady Gaga fr?n mic 1 till mic 4 och tillbaks
%25_245: massor av klappar vid mic 1
%25_246: ABBA i mitten
%25_247: Green Day vid mic 2 på golvet


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

micMatrix = [0 0 1.70; 0 1.80 1.70; 1.57 0 1.70; 1.57 1.80 1.70];
lsb = [-1,-1,0];
usb = [max(micMatrix(:,1)) + 1,max(micMatrix(:,2)) + 1,3];

[xS, yS, zS] = LM(mic1, mic2, mic3, mic4, micMatrix, lsb, usb);

scatterPlot(micMatrix, xS, yS, zS, lsb, usb);

