clear all
close all

[mic1, f] = audioread('000306_249_mono1.wav');
[mic2, f] = audioread('000306_249_mono2.wav');
[mic3, f] = audioread('000306_249_mono3.wav');
[mic4, f] = audioread('000306_249_mono4.wav');

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

lsb = [-1,-1,1.5];
usb = [max(micMatrix(:,1)) + 1,max(micMatrix(:,2)) + 1,1.9];

%%
s = 1200000:1400000;
signalMatrix{1} = mic1(s); signalMatrix{2} = mic2(s); signalMatrix{3} = mic3(s); signalMatrix{4} = mic4(s);
% figure
% plot(mic3(s))
% hold on

nbrOfSpeakers = 4;
position = LMComboBalloon(signalMatrix, nbrOfSpeakers, micMatrix, lsb, usb);

%Plots them
plotSpeakers(micMatrix, 4, lsb, usb);
hold on
scatter3(position(:,1),position(:,2),position(:,3),'*k')
a = [1:4]'; b = num2str(a); c = cellstr(b);
dx = 0.2; dy = 0.2; dz = 0.2;
text(position(:,1)+dx, position(:,2)+dy, position(:,3)+dz, c);






