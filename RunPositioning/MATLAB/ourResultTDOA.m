close all
clear all

micMatrix = [0 0 1; 0 8.2 1; 3.2 0 1; 3.2 8.2 1];
nbrOfSpeakers = length(micMatrix(:,1));
lsb = [-1,-1,1];
usb = [max(micMatrix(:,1)) + 1,max(micMatrix(:,2)) + 1, 2];
[signalMatrix, f] = readSavedData(nbrOfSpeakers, '100hits');

%Finds the sound source in time
[startSoundArray, endSoundArray, nbrOfSound] = calcStartSounds(signalMatrix{1}, 20 ,5);
if nbrOfSound == 0
    return;
end

%Choose which sound to calculate, or calculate all of them if 0 is chosen
soundNbr = 0;

%Position the sound source, choose between
%   calcPos, calcPosCombo, SRP-PHAT
%Then choose the method to calculate TDOA
%   GCCPhat, GCCScores, MovingAverage
methods = {'calcPos', 'AED'};
x0 = [usb(1)/2, usb(2)/2, usb(3)/2];
positionMatrix = positioningShell(signalMatrix, micMatrix, f, x0, lsb, usb, nbrOfSpeakers, methods, soundNbr, nbrOfSound, startSoundArray, endSoundArray);

tmpPositionMatrix = [];
j=1;
for i=1:length(positionMatrix)
   if positionMatrix(i,1) > 0.001
       tmpPositionMatrix(j,:) = positionMatrix(i,:);
       j = j+1;
   end
end


%Plots the results
numbering = 0;
ourPlot(micMatrix, nbrOfSpeakers, tmpPositionMatrix, lsb, usb, numbering)

%Calculate the mean error
for i =1:length(tmpPositionMatrix)
    errorMatrix(i) = norm(tmpPositionMatrix(i,1:2) - [1.6 5]);
end
standardDeviation = std(errorMatrix);
meanError = mean(errorMatrix);

