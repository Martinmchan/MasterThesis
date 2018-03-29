%The main function that calls everything
clear all
close all

%Initiate data
micMatrix = [0 0 1.74; 0 23 1.74; 2 23 1.74; 2 0 1.74];
nbrOfSpeakers = length(micMatrix(:,1));
lsb = [-1,-1,1];
usb = [max(micMatrix(:,1)) + 1,max(micMatrix(:,2)) + 1,2];
%namebase = '_0320_11.wav'; type = 'n';
namebase = './tascam/000306_256_mono'; type = 't';

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
if nbrOfSound == 0
    return;
end

%Choose which sound to calculate, or calculate all of them if 0 is chosen
soundNbr = 0;

%Choose if noise should be totally removed
noiseRemoval = 0;
if noiseRemoval
    for i = 1:nbrOfSpeakers
        signalMatrix{i} = ourTotalNoiseRemoval(signalMatrix{i});
    end
end


%Position the sound source, choose between
%   calcPos, calcPosCombo, SRP-PHAT
%Then choose the method to calculate TDOA
%   GCCPhat, GCCScores, MovingAverage
methods = {'calcPos', 'MovingAverage'};
x0 = [usb(1)/2, usb(2)/2, usb(3)/2];
positionMatrix = positioningShell(signalMatrix, micMatrix, f, x0, lsb, usb, nbrOfSpeakers, methods, soundNbr, nbrOfSound, startSoundArray, endSoundArray);


%Plots the results
numbering = 1;
ourPlot(micMatrix, nbrOfSpeakers, positionMatrix, lsb, usb, numbering)



