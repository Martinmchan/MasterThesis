function mainFunction

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

namebase = '_0402_15.wav'; type = 'n';
%namebase = './tascam/000312_243_mono'; type = 't';

%Read data
[signalMatrix, f] = readData(type, namebase, nbrOfSpeakers);

%Syncs the signals if needed
syncNeeded = 0;
if syncNeeded
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

end

