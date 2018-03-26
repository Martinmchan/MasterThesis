%The main function that calls everything
clear all
close all

%Choose between tascam or NCS
type = 'n';

%Initiate and read all data
micMatrix = [0 0 1.7; 0.9 0 0.1; 1.83 0 0.5; 0 2.4 0.1; 1.83 2.40 1.8; 0 4.45 1.1; 0.9 4.45 0.1; 1.83 4.45 1.08];
microphones =  {'mic1_0320_10.wav';'mic2_0320_10.wav';'mic3_0320_10.wav';'mic4_0320_10.wav';'mic5_0320_10.wav';'mic6_0320_10.wav';'mic7_0320_10.wav';'mic8_0320_10.wav'};
nbrOfSpeakers = length(microphones);

signalMatrix = [];
f=0;
for i = 1:nbrOfSpeakers
    [mic, f] = audioread(microphones{i});
    mic = mic - mean(mic);
    signalMatrix{i} = mic;
end

%Syncs the signals if NCS is chosen
if type == 'n'
    fastSync = 1;
    quality = 0;
    [signalMatrix, quality] = generateSyncedSignals(signalMatrix, nbrOfSpeakers, quality, fastSync);
end

%Finds the sound source in time
[startSoundArray, endSoundArray, nbrOfSound] = calcStartSounds(signalMatrix{1}, 20 ,5);

%Choose which sound to calculate, or calculate all of them if 0 is chosen
soundNbr = 0;

%Position the sound source, choose between
%   calcPos, calcPosCombo, SRP-PHAT
%Then choose the method to calculate TDOA
%   GCCPhat, GCCScores, MovingAverage
methods = {'calcPos', 'MovingAverage'};
lsb = [-1,-1,-1];
usb = [3,7,3];
x0 = [usb(1)/2, usb(2)/2, usb(3)/2];
positionMatrix = positioningShell(signalMatrix, micMatrix, f, x0, lsb, usb, nbrOfSpeakers, methods, soundNbr, nbrOfSound, startSoundArray, endSoundArray);


%Plots the results
ourPlot(micMatrix, nbrOfSpeakers, positionMatrix, lsb, usb)







