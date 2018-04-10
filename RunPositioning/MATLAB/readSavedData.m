function [signalMatrix, f] = readSavedData(nbrOfSpeakers,prefix)

    microphones{1} = 0;
    for i = 1:nbrOfSpeakers
        microphones{i} = sprintf('%s%s%s%d%s','../savedfiles/',prefix,'mic',i,'.wav');
    end
   
    f=0;
    for i = 1:nbrOfSpeakers
        [mic, f] = audioread(microphones{i});
        mic = mic - mean(mic);
        signalMatrix{i} = mic;
    end
    
end
    
