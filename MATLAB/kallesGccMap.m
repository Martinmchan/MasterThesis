clear all
close all

[mic1, f] = audioread('000224_242_mono1.wav');
[mic2, f] = audioread('000224_242_mono2.wav');
[mic3, f] = audioread('000224_242_mono3.wav');
[mic4, f] = audioread('000224_242_mono4.wav');

mic1 = ourFilter(mic1,1,60);
mic2 = ourFilter(mic2,1,60);
mic3 = ourFilter(mic3,1,60);
mic4 = ourFilter(mic4,1,60);

sz = length(mic1);

window = 2000;
gccMap = [];


for i = 1:window:sz-window
    gcc = returnFullGCC(mic1(i:i+window), mic2(i:i+window));
    gccMap = [gccMap gcc];
end

xAxis = 1:floor(sz/window);
yAxis = 343/48000*[-floor(window/2):floor(window/2)];


mesh(xAxis, yAxis, gccMap)










