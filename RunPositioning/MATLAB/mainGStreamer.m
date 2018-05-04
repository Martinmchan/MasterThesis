close all
clear all 
%The main function that calls everything
fileID = fopen('../configuration.txt');
confFile = textscan(fileID,'%s', 'delimiter', '\t','collectoutput',true);
confFile=confFile{1};
fclose(fileID);

%Initiate data
micMatrix = str2num(confFile{end});
nbrOfSpeakers = length(micMatrix(:,1));
lsb = [-1,-1,1];
usb = [max(micMatrix(:,1)) + 1,max(micMatrix(:,2)) + 1, 2];

%Read data and plot
[signalMatrix, f] = readData(nbrOfSpeakers);
figure
hold on
for i = 1:nbrOfSpeakers
    plot(signalMatrix{i})
end

%Finds the sound sources in time
[startSoundArray, endSoundArray, nbrOfSound] = calcStartSounds(signalMatrix{1}, 20 ,5);
if nbrOfSound == 0
    return;
end

%Choose which sound to calculate, or calculate all of them if 0 is chosen
soundNbr = 1;

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

%Calculate latencies
[latencies, ~, ~] = ourCalibrateComplex(signalMatrix, nbrOfSpeakers, micMatrix, startSoundArray, endSoundArray, 7);
for i = 2:nbrOfSpeakers
    latency = round(latencies(i - 1)*48000/343);
    if latency < 0
        signalMatrix{i} = [zeros(-latency,1); signalMatrix{i}];
    elseif latency > 0
        signalMatrix{i} = signalMatrix{i}(latency:end);
    end
end
positionMatrixSynced = positioningShell(signalMatrix, micMatrix, f, x0, lsb, usb, nbrOfSpeakers, methods, soundNbr, nbrOfSound, startSoundArray, endSoundArray);


fileID = fopen('100GStreamer.txt','a');
fprintf(fileID,'%d %d %d %d\n',positionMatrix(1), positionMatrix(2), positionMatrix(3),max(abs(latencies)));
fclose(fileID);

fileID = fopen('100ComplexSyncedPos.txt','a');
fprintf(fileID,'%d %d %d %d\n',positionMatrixSynced(1), positionMatrixSynced(2), positionMatrixSynced(3),max(abs(latencies)));
fclose(fileID);


