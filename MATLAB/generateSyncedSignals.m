function [syncedSignalMatrix, quality] = generateSyncedSignals(signalMatrix, nbrOfSpeakers, calcQuality, fastSync)
    
    [startSoundArray, endSoundArray, nbrSound] = calcStartSounds(signalMatrix{1}(1:nbrOfSpeakers*200000),3);
    
    sVec{1} = 0;
    if fastSync
        if nbrSound == nbrOfSpeakers
            disp("Synchronizing with fast method.")
            for i = 1:nbrOfSpeakers
                sVec{i} = startSoundArray(i):endSoundArray(i);
            end
        else
            disp("Couldn't synchronize with fast method, using slow instead.")
            for i = 1:nbrOfSpeakers
                sVec{i} = (i*200000 - 199999):i*200000; 
            end
        end
    else
        disp("Synchronizing with fast method.")
        for i = 1:nbrOfSpeakers
            sVec{i} = (i*200000 - 199999):i*200000; 
        end
    end
    
    for i = 2:nbrOfSpeakers
        [mic, distance, ~] = ourSync(signalMatrix{1}, signalMatrix{i}, sVec{1}, sVec{i});
        signalMatrix{i} = mic;
        dist(i) = distance;
    end

    if calcQuality
        quality = ManyCheckSyncQuality(micMatrix, dist, signalMatrix, nbrOfSpeakers, sVec);
    else
        quality = 0;
    end
    
    for i = 1:nbrOfSpeakers
        syncedSignalMatrix{i} = signalMatrix{i}(nbrOfSpeakers*200000:end);
    end

    figure;
    hold on
    for i = 1:nbrOfSpeakers
        plot(signalMatrix{i}(1:nbrOfSpeakers*200000))
    end
    
end