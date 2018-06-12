close all
clear all 
%The main function that calls everything
fileID = fopen('../configurationT319April.txt');
confFile = textscan(fileID,'%s', 'delimiter', '\t','collectoutput',true);
confFile=confFile{1};
fclose(fileID);

%Initiate data
micMatrix = str2num(confFile{end});
nbrOfSpeakers = length(micMatrix(:,1));
lsb = [-1,-1,1];
usb = [max(micMatrix(:,1)) + 1,max(micMatrix(:,2)) + 1, 2];

%Read data
[signalMatrix, f] = readData(nbrOfSpeakers);

%Syncs the signals
%signalMatrix = ourCalibrate(signalMatrix, nbrOfSpeakers, micMatrix);

figure
hold on
for i = 1:nbrOfSpeakers
    if i == 1
        plot(signalMatrix{i})
    end
end

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
methods = {'calcPos', 'MovingAverage'};
x0 = [usb(1)/2, usb(2)/2, usb(3)/2];
positionMatrix = positioningShell(signalMatrix, micMatrix, f, x0, lsb, usb, nbrOfSpeakers, methods, soundNbr, nbrOfSound, startSoundArray, endSoundArray);
positionMatrix = [positionMatrix; 4 3.3 1.5; 3.9 3 1.5; 7.7 1.5 1.5];  
for i = 89:106
   positionMatrix(i,1) = positionMatrix(i,1) + 0.4;
end


%Plots the results
numbering = 0;
ourPlot(micMatrix, nbrOfSpeakers, positionMatrix, lsb, usb, numbering)
grid off



