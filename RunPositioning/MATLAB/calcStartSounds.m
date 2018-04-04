function [startSoundArray, endSoundArray, nbrOfSound] = calcStartSounds(signal, treshold, spacing)
    
    figure
    plot(signal)
    hold on

    sz = length(signal);
    counter = 1;
    nbrOfSound = 0;
    startSoundArray = [];
    endSoundArray = [];
    nbrSamples = 10000;
    
    while counter < sz - nbrSamples
        [tStart, tEnd] = findSound(signal(counter:sz), nbrSamples, treshold);
        if (tStart ~= 0) && (tEnd ~= 0)
            tempStart = tStart - spacing*nbrSamples;
            tempEnd = tEnd + spacing*nbrSamples;
            startSoundArray = [startSoundArray (counter + tempStart)];
            endSoundArray = [endSoundArray (counter + tempEnd)];
            counter = counter + tEnd;
            nbrOfSound = nbrOfSound + 1;
        else
            break;
        end
    end
    
    if ~isempty(startSoundArray) && ~isempty(endSoundArray)
        for i = 1:nbrOfSound
            plot(startSoundArray(i),0,'o')
            plot(endSoundArray(i),0,'o')
        end
    end
    
end