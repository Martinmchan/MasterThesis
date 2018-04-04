function positionMatrix = positioningShell(signalMatrix, micMatrix, f, x0, lsb, usb, nbrOfSpeakers, methods, soundNbr, nbrOfSound, startSoundArray, endSoundArray)
if soundNbr > 0
    for i = 1:nbrOfSpeakers
        tempSignalMatrix{i} = signalMatrix{i}(startSoundArray(soundNbr):endSoundArray(soundNbr)); 
    end
    positionMatrix = positioning(tempSignalMatrix, micMatrix, f, x0, lsb, usb, nbrOfSpeakers, methods);
else
    positionMatrix = [];
    if endSoundArray(nbrOfSound) > length(signalMatrix{1})
        nbrOfSound = nbrOfSound - 1;
    end
    for i = 1:nbrOfSound
        for j = 1:nbrOfSpeakers
            tempSignalMatrix{j} = signalMatrix{j}(startSoundArray(i):endSoundArray(i)); 
        end
        positionMatrix = [positionMatrix; positioning(tempSignalMatrix, micMatrix, f, x0, lsb, usb, nbrOfSpeakers, methods)];
    end
end