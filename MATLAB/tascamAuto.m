clear all
close all

[mic1, f] = audioread('000306_255_mono1.wav');
[mic2, f] = audioread('000306_255_mono2.wav');
[mic3, f] = audioread('000306_255_mono3.wav');
[mic4, f] = audioread('000306_255_mono4.wav');
% 
% mic1 = ourFilter(mic1,1,200);
% mic2 = ourFilter(mic2,1,200);
% mic3 = ourFilter(mic3,1,200);
% mic4 = ourFilter(mic4,1,200);

plot(mic1)
hold on
plot(mic2)
plot(mic3)
plot(mic4)

micMatrix = [0 0 1.74; 0 23 1.74; 2 23 1.74; 2 0 1.74];
sz = length(mic1);

lsb = [-1,-1,1.5];
usb = [max(micMatrix(:,1)) + 1,max(micMatrix(:,2)) + 1,1.9];

figure
plot(mic1)
hold on


[startSoundArray, endSoundArray, nbrSound] = calcStartSounds(mic1);

for i = 1:length(startSoundArray)
    plot(startSoundArray(i),0,'o')
    plot(endSoundArray(i),0,'o')
end


nbrOfSpeakers = 4;
plotSpeakers(micMatrix, nbrOfSpeakers, lsb, usb);
sX = [];
sY = [];
sZ = [];


hold on
for i = 1:nbrSound
    s = startSoundArray(i):endSoundArray(i);
    signalMatrix{1} = mic1(s); signalMatrix{2} = mic2(s); signalMatrix{3} = mic3(s); signalMatrix{4} = mic4(s);
    [xS, yS, zS] = ManyLMBalloon(signalMatrix, nbrOfSpeakers, micMatrix, lsb, usb);
    sX = [sX; xS];
    sY = [sY; yS];
    sZ = [sZ; zS];
end



scatter3(sX, sY, sZ,'*k')
a = [1:nbrSound]'; b = num2str(a); c = cellstr(b);
dx = 0.2; dy = 0.2; dz = 0.2;
text(sX+dx, sY+dy, sZ+dz, c);







