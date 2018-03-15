close all;
clear all;

%Initialize camera position, number of speakers and the names of the files
micMatrix = [0 0 1.7; 0.9 0 0.1; 1.83 0 0.5; 0 2.4 0.1; 1.83 2.40 1.8; 0 4.45 1.1; 0.9 4.45 0.1; 1.83 4.45 1.08];
nbrOfSpeakers = 8;

microphones = {'mic1_0315_9.wav';'mic2_0315_9.wav';'mic3_0315_9.wav';'mic4_0315_9.wav';'mic5_0315_9.wav';'mic6_0315_9.wav';'mic7_0315_9.wav';'mic8_0315_9.wav'};


%Reads the data and plots them
signalMatrix = [];
f=0;
for i = 1:nbrOfSpeakers
    [mic, f] = audioread(microphones{i});
    mic = mic - mean(mic);
    mic = ourFilter(mic,1,60);
    signalMatrix{i} = mic;
    hold on
    plot(mic);
end

%Syncs all the microphones using mic1 as master, then plot the result.
%Distance between the microphones are also shown as an indicator of how
%good the sync was.
j=200000;
figure;
plot(signalMatrix{1});
s1 = 1:200000;
for i = 2:nbrOfSpeakers
   s = j:j+200000;
   [mic, distance, ~] = ourSync(signalMatrix{1}, signalMatrix{i}, s1, s);
   signalMatrix{i} = mic;
   sVec(i) = j;
   j = j+200000;
   hold on
   plot(signalMatrix{i});
   dist(i) = distance;
end

quality = ManyCheckSyncQuality(micMatrix, dist, signalMatrix, nbrOfSpeakers, sVec);

%Generate the data after sync
figure;
for i = 1:nbrOfSpeakers
    signalMatrix{i} = signalMatrix{i}(j:end);
    plot(signalMatrix{i});
    hold on;
end

%%
%Initialize the signal and the boundaries on the room

s = 1:3400000;
lsb = [-1,-1,-1];
usb = [3,5,3];

%Change the length of the microphones
for i=1:nbrOfSpeakers
    signalMatrix{i} = signalMatrix{i}(s);
end

%Calculates the sound source position
%Levenberg-Marquardt
%[xLM, yLM, zLM] = ManyLM(signalMatrix, nbrOfSpeakers, micMatrix, lsb, usb);

%Combo LMs
pointMatrix = LMCombo(signalMatrix, nbrOfSpeakers, micMatrix, lsb, usb);

%SRP-Phat
microphones = [];
for i=1:nbrOfSpeakers
   mic = signalMatrix{i};
   microphones = [microphones mic];
end
SRPMatrix = zeros(3,35);

for i = 1:length(SRPMatrix(1,:))
    [finalpos,finalsrp,finalfe]=srplems(microphones, micMatrix, f, lsb, usb);
    xSRP = finalpos(1,1); ySRP = finalpos(1,2); zSRP = finalpos(1,3);
    SRPMatrix(1,i) = xSRP; SRPMatrix(2,i) = ySRP; SRPMatrix(3,i) = zSRP;
end
xSRP = mean(SRPMatrix(1,:));ySRP = mean(SRPMatrix(2,:));zSRP = mean(SRPMatrix(3,:));

%Scatterplots them.
plotSpeakers(micMatrix, nbrOfSpeakers, lsb, usb);

%%
hold on
%scatter3(xLM,yLM,zLM,'*k')
scatter3(xSRP,ySRP,zSRP,'*g')

% for i = 1:length(pointMatrix(1,:))
%     scatter3(pointMatrix(1,i),pointMatrix(2,i),pointMatrix(3,i),'*b')
% end

xCombo = mean(pointMatrix(1,:));yCombo = mean(pointMatrix(2,:));zCombo = mean(pointMatrix(3,:));
scatter3(xCombo,yCombo,zCombo,'*c')

xAllMean = mean([xSRP xCombo]);yAllMean = mean([ySRP yCombo]);zAllMean = mean([zSRP zCombo]);
scatter3(xAllMean,yAllMean,zAllMean,'*m')
