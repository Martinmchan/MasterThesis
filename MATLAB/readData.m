function [signalMatrix, f] = readData(type, namebase, nbrOfSpeakers)

    microphones{1} = 0;
    if type == 'n'
        for i=1:nbrOfSpeakers
            microphones{i} = sprintf('%s%d%s','mic',i,namebase);
        end
    elseif type == 't'
        for i=1:nbrOfSpeakers
            microphones{i} = sprintf('%s%d%s',namebase,i,'.wav');
        end
    end

    signalMatrix = [];
    f=0;
    for i = 1:nbrOfSpeakers
        [mic, f] = audioread(microphones{i});
        mic = mic - mean(mic);
        signalMatrix{i} = mic;
    end
    
end
    