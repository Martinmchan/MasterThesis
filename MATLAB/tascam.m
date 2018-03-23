clear all
close all

[mic1, f] = audioread('000306_257_mono1.wav');
[mic2, f] = audioread('000306_257_mono2.wav');
[mic3, f] = audioread('000306_257_mono3.wav');
[mic4, f] = audioread('000306_257_mono4.wav');

mic1 = ourFilter(mic1,1,200);
mic2 = ourFilter(mic2,1,200);
mic3 = ourFilter(mic3,1,200);
mic4 = ourFilter(mic4,1,200);

plot(mic1)
hold on
plot(mic2)
plot(mic3)
plot(mic4)

micMatrix = [0 0 1.74; 0 23 1.74; 2 23 1.74; 2 0 1.74];

lsb = [-1,-1,1.5];
usb = [max(micMatrix(:,1)) + 1,max(micMatrix(:,2)) + 1,1.9];

%%
s = 1:1200000;
signalMatrix{1} = mic1(s); signalMatrix{2} = mic2(s); signalMatrix{3} = mic3(s); signalMatrix{4} = mic4(s);
figure
plot(mic2)
hold on

nbrOfSpeakers = 4;
[xS, yS, zS] = ManyLMBalloon(signalMatrix, nbrOfSpeakers, micMatrix, lsb, usb);



% microphones = [mic1 mic2 mic3 mic4];
% SRPMatrix = zeros(3,35);
% for i = 1:length(SRPMatrix(1,:))
%     [finalpos,finalsrp,finalfe]=srplems(microphones, micMatrix, f, lsb, usb);
%     xSRP = finalpos(1,1); ySRP = finalpos(1,2); zSRP = finalpos(1,3);
%     SRPMatrix(1,i) = xSRP; SRPMatrix(2,i) = ySRP; SRPMatrix(3,i) = zSRP;
% end
% xSRP = mean(SRPMatrix(1,:));ySRP = mean(SRPMatrix(2,:));zSRP = mean(SRPMatrix(3,:));


%%
%Plots them
plotSpeakers(micMatrix, 4, lsb, usb);

hold on
scatter3(xS,yS,zS,'*k')

