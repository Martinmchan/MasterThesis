function [syncedSignalMatrix, quality] = generateSyncedSignals(signalMatrix, nbrOfSpeakers, calcQuality)
    
    [startSoundArray, endSoundArray, nbrSound] = calcStartSounds(signalMatrix{1}(1:nbrOfSpeakers*200000));
  
    sVec{1} = startSoundArray(1):endSoundArray(1);
    for i = 2:nbrOfSpeakers
        s = startSoundArray(i):endSoundArray(i);
        [mic, distance, ~] = ourSync(signalMatrix{1}, signalMatrix{i}, sVec{1}, s);
        signalMatrix{i} = mic;
        sVec{i} = s;
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