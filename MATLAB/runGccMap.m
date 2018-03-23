clear all
close all

[mic1, f] = audioread('000224_244_mono1.wav');
[mic2, f] = audioread('000224_244_mono2.wav');
[mic3, f] = audioread('000224_244_mono3.wav');
[mic4, f] = audioread('000224_244_mono4.wav');

mic1 = ourFilter(mic1,1,200);
mic2 = ourFilter(mic2,1,200);
mic3 = ourFilter(mic3,1,200);
mic4 = ourFilter(mic4,1,200);

sz = length(mic1);

window = 2000;
gccMap = [];


for i = 1:window:sz-window
    gcc = returnFullGCC(mic1(i:i+window), mic4(i:i+window));
    gccMap = [gccMap gcc];
end

xAxis = 1:floor(sz/window);
yAxis = 343/48000*[-floor(window/2):floor(window/2)];


imagesc(xAxis, yAxis, gccMap)
figure
mesh(xAxis, yAxis, gccMap)







