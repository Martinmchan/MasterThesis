clear all
close all

[mic1, f] = audioread('000224_242_mono1.wav');
[mic2, f] = audioread('000224_242_mono2.wav');
[mic3, f] = audioread('000224_242_mono3.wav');
[mic4, f] = audioread('000224_242_mono4.wav');

mic1 = ourFilter(mic1,1,200);
mic2 = ourFilter(mic2,1,200);
mic3 = ourFilter(mic3,1,200);
mic4 = ourFilter(mic4,1,200);

plot(mic2)

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

microphones = [mic1 mic2 mic3 mic4];
SRPMatrix = zeros(3,35);
for i = 1:length(SRPMatrix(1,:))
    [finalpos,finalsrp,finalfe]=srplems(microphones, micMatrix, f, lsb, usb);
    xSRP = finalpos(1,1); ySRP = finalpos(1,2); zSRP = finalpos(1,3);
    SRPMatrix(1,i) = xSRP; SRPMatrix(2,i) = ySRP; SRPMatrix(3,i) = zSRP;
end
xSRP = mean(SRPMatrix(1,:));ySRP = mean(SRPMatrix(2,:));zSRP = mean(SRPMatrix(3,:));

%Plots them
plotSpeakers(micMatrix, 4, lsb, usb);
hold on
scatter3(xS,yS,zS,'*k')
scatter3(xSRP,ySRP,zSRP,'*g')
