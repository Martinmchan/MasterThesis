close all;
clear all;

%Initialize camera position, number of speakers and the names of the files
micMatrix = [0 0 1.7; 0.9 0 0.1; 1.83 0 0.5; 0 2.4 0.1; 1.83 2.40 1.8; 0 4.45 1.1; 0.9 4.45 0.1; 1.83 4.45 1.08];
nbrOfSpeakers = 8;
microphones = {'mic1_0315_8.wav';'mic2_0315_8.wav';'mic3_0315_8.wav';'mic4_0315_8.wav';'mic5_0315_8.wav';'mic6_0315_8.wav';'mic7_0315_8.wav';'mic8_0315_8.wav'};
facit = [1.7 4.35 1];

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
j=200001;
figure;
plot(signalMatrix{1});
sVec{1} = 1:200000;
for i = 2:nbrOfSpeakers
   s = j:j+200000;
   [mic, distance, ~] = ourSync(signalMatrix{1}, signalMatrix{i}, sVec{1}, s);
   signalMatrix{i} = mic;
   sVec{i} = s;
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

s = 1:3000000;
lsb = [-1,-1,-1];
usb = [3,5,3];
%Change the length of the microphones
for i=1:nbrOfSpeakers
    syncedSignalMatrix{i} = signalMatrix{i}(s);
end

%LM
[xLM, yLM, zLM] = ManyLM(syncedSignalMatrix, nbrOfSpeakers, micMatrix, lsb, usb);

%Gcc-scores
[xScore, yScore, zScore] = ManyLMScores(syncedSignalMatrix, nbrOfSpeakers, micMatrix, lsb, usb);

%Scatterplots them.
plotSpeakers(micMatrix, nbrOfSpeakers, lsb, usb);
hold on
scatter3(xScore,yScore,zScore,'*m')
scatter3(xLM,yLM,zLM,'*b')

%%

%Checks and print the errors
errSRP = norm([xSRP ySRP zSRP] - facit);
errCombo = norm([xCombo yCombo zCombo] - facit);
errAllMean = norm([xAllMean yAllMean zAllMean] - facit);
errBalloon = norm([xLM yLM zLM] - facit);

disp("Error SRP: " + errSRP);
disp("Error Combo: " + errCombo);
disp("Error AllMean: " + errAllMean);
disp("Error Balloon: " + errBalloon);
