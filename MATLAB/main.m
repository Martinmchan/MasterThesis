%The main function that calls everything
clear all
close all

%Choose between tascam or NCS
type = 'n';

%Initiate and read all data
micMatrix = [0 0 1.7; 0.9 0 0.1; 1.83 0 0.5; 0 2.4 0.1; 1.83 2.40 1.8; 0 4.45 1.1; 0.9 4.45 0.1; 1.83 4.45 1.08];
microphones =  {'mic1_0320_18.wav';'mic2_0320_18.wav';'mic3_0320_18.wav';'mic4_0320_18.wav';'mic5_0320_18.wav';'mic6_0320_18.wav';'mic7_0320_18.wav';'mic8_0320_18.wav'};
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

%Position the sound source, choose between
%   calcPos, calcPosCombo, SRP-PHAT
%Then choose the method to calculate TDOA
%   GCCPhat, GCCScores, MovingAverage
methods = {'SRP-Phat', 35; 'LM', 'GCCPhat'};
positionMatrix = positioning(signalMatrix, f, x0, lsb, usb, nbrOfSpeakers, methods);

