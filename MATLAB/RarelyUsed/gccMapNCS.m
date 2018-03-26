clear all
close all

[mic1, f] = audioread('mic1_0315_2.wav');
[mic2, f] = audioread('mic2_0315_2.wav');

mic1 = mic1 - mean(mic1);
mic2 = mic2 - mean(mic2);

mic1 = ourFilter(mic1,1,200);
mic2 = ourFilter(mic2,1,200);

plot(mic1)
hold on
plot(mic2)

[mic2, dist, ~] = ourSync(mic1,mic2,1:100000,100001:200000);

figure
plot(mic1)
hold on
plot(mic2)

%%

mic1 = mic1(1600000:5000000);
mic2 = mic2(1600000:5000000);

%%
sz1 = length(mic1);
sz2 = length(mic2);
sz = min([sz1 sz2]);

window = 2000;
gccMap = [];


for i = 1:window:sz-window
    gcc = returnFullGCC(mic1(i:i+window), mic2(i:i+window));
    gccMap = [gccMap gcc];
end

xAxis = 1:floor(sz/window);
yAxis = 343/48000*[-floor(window/2):floor(window/2)];

figure
mesh(xAxis, yAxis, gccMap)

