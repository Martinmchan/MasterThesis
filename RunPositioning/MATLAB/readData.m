function [signalMatrix, f] = readData(nbrOfSpeakers)

    microphones{1} = 0;
    for i = 1:nbrOfSpeakers
        microphones{i} = sprintf('%s%d%s','../tmp/tmp',i,'.wav');
    end
   
    f=0;
    for i = 1:nbrOfSpeakers
        [mic, f] = audioread(microphones{i});
        mic = mic - mean(mic);
        signalMatrix{i} = mic;
    end
    
end
    
