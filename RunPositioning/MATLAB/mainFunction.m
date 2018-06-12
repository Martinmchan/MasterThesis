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

%Read data and plot
[signalMatrix, f] = readSavedData(nbrOfSpeakers,'AXIS');
%figure
%hold on
for i = 1:1
    %plot(signalMatrix{i})
end

%Finds the sound sources in time
[startSoundArray, endSoundArray, nbrOfSound] = calcStartSounds(signalMatrix{1}, 20 ,5);
if nbrOfSound == 0
    return;
end
if nbrOfSound > 2 && nbrOfSpeakers > 4
    [latencies, tryMatrix] = ourCalibrateComplex(signalMatrix, nbrOfSpeakers, micMatrix, startSoundArray, endSoundArray, nbrOfSound);
    differenceFound = 0;
    for i=2:nbrOfSound
        if norm(tryMatrix(1,1:2) - tryMatrix(i,1:2)) > 0.5
            for j = i+1:nbrOfSound
                if norm(tryMatrix(i,1:2) - tryMatrix(j,1:2)) > 0.5
                    differenceFound = 1;
                end
            end
        end
    end
    
    if differenceFound
        for i = 2:nbrOfSpeakers
            latency = round(latencies(i - 1)*48000/343);
            if latency < 0
                signalMatrix{i} = [zeros(-latency,1); signalMatrix{i}];
            elseif latency > 0
                signalMatrix{i} = signalMatrix{i}(latency:end);
            end
        end
    end
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

%Plots the results
numbering = 0;
%ourPlot(micMatrix, nbrOfSpeakers, positionMatrix, lsb, usb, numbering)
ourPlotXY(micMatrix, nbrOfSpeakers, positionMatrix, lsb, usb, numbering);
grid on;

