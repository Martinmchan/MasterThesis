%The main function that calls everything
clear all
close all

%Choose between tascam or NCS
type = 'n';

%Initiate data
micMatrix = [0 0 1.7; 0.9 0 0.1; 1.83 0 0.5; 0 2.4 0.1; 1.83 2.40 1.8; 0 4.45 1.1; 0.9 4.45 0.1; 1.83 4.45 1.08];
nbrOfSpeakers = length(micMatrix(:,1));
lsb = [-1,-1,0];
usb = [max(micMatrix(:,1)) + 1,max(micMatrix(:,2)) + 1,2];
namebase = '_0320_10.wav';
%namebase = '000306_255_mono';

%Read data
[signalMatrix, f] = readData(type, namebase, nbrOfSpeakers);


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
methods = {'calcPosTwice', 'MovingAverage'};
x0 = [usb(1)/2, usb(2)/2, usb(3)/2];
positionMatrix = positioningShell(signalMatrix, micMatrix, f, x0, lsb, usb, nbrOfSpeakers, methods, soundNbr, nbrOfSound, startSoundArray, endSoundArray);


%Plots the results
ourPlot(micMatrix, nbrOfSpeakers, positionMatrix, lsb, usb)



