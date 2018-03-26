%The main function that calls everything
clear all
close all

%Choose between tascam or NCS
type = 't';

%Initiate data
micMatrix = [0 0 1.74; 0 23 1.74; 2 23 1.74; 2 0 1.74];
nbrOfSpeakers = 4;

%namebase = '_0320_10.wav';
namebase = '000306_255_mono';

%Read data
[signalMatrix, f] = readData(type, namebase, nbrOfSpeakers);

%Syncs the signals if NCS is chosen
if type == 'n'
    fastSync = 1;
    quality = 0;
    [signalMatrix, quality] = generateSyncedSignals(signalMatrix, nbrOfSpeakers, quality, fastSync);
end

%Finds the sound source in time
[startSoundArray, endSoundArray, nbrSound] = calcStartSounds(signalMatrix{1}, 20 ,5);

%Choose which sound to calculate, or calculate all of them if 0 is chosen
soundNbr = 0;

%Position the sound source, choose between
%   calcPos, calcPosCombo, SRP-PHAT
%Then choose the method to calculate TDOA
%   GCCPhat, GCCScores, MovingAverage
methods = {'calcPos4Combo', 'MovingAverage'; 'calcPos4Combo', 'GCCphat'};
lsb = [-1,-1,-1];
usb = [3,7,3];
x0 = [usb(1)/2, usb(2)/2, usb(3)/2];
if soundNbr > 0
    for i = 1:nbrOfSpeakers
        tempSignalMatrix{i} = signalMatrix{i}(startSoundArray(soundNbr):endSoundArray(soundNbr)); 
    end
    positionMatrix = positioning(tempSignalMatrix, micMatrix, f, x0, lsb, usb, nbrOfSpeakers, methods);
else
    positionMatrix = [];
    for i = 1:nbrSound
        for j = 1:nbrOfSpeakers
            tempSignalMatrix{j} = signalMatrix{j}(startSoundArray(i):endSoundArray(i)); 
        end
    positionMatrix = [positionMatrix; positioning(tempSignalMatrix, micMatrix, f, x0, lsb, usb, nbrOfSpeakers, methods)];
   end
end
    

