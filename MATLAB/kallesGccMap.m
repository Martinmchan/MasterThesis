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

[mic1, f] = audioread('000225_247_mono1.wav');
[mic2, f] = audioread('000225_247_mono2.wav');
[mic3, f] = audioread('000225_247_mono3.wav');
[mic4, f] = audioread('000225_247_mono4.wav');

mic1 = ourFilter(mic1,1,60);
mic2 = ourFilter(mic2,1,60);
mic3 = ourFilter(mic3,1,60);
mic4 = ourFilter(mic4,1,60);

sz = length(mic1);

window = 2000;
gccMap = [];


for i = 1:window:sz-window
    gcc = returnAllGccphat(mic2(i:i+window), mic3(i:i+window));
    gccMap = [gccMap gcc];
end

xAxis = 1:floor(sz/window);
yAxis = 343/48000*[-floor(window/2):floor(window/2)];


mesh(xAxis, yAxis, gccMap)










