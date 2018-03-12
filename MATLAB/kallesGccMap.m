%157x180x170
%24_240: G-dragon vid mic 1
%24_241: Spice girls fr?n mic 1 till mic 2 och tillbaks
%24_242: The Sounds vid mic 1
%-----------------------------------------
%285x285x155
%24_243: Britney Spears vid mic 1
%24_244: Lady Gaga fr?n mic 1 till mic 4 och tillbaks


clear all
close all

[mic1, f] = audioread('000224_244_mono1.wav');
[mic2, f] = audioread('000224_244_mono2.wav');
[mic3, f] = audioread('000224_244_mono3.wav');
[mic4, f] = audioread('000224_244_mono4.wav');

sz = length(mic1);

window = 2000;
gccMap = [];


for i = 1:window:sz-window
    gcc = returnAllGccphat(mic1(i:i+window), mic4(i:i+window));
    gccMap = [gccMap gcc];
end

xAxis = 1:floor(sz/window);
yAxis = 343/48000*[-floor(window/2):floor(window/2)];


mesh(xAxis, yAxis, gccMap)










