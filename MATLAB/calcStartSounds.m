function [startSoundArray, endSoundArray, nbrSound] = calcStartSounds(signal)
    
    figure
    plot(signal)
    hold on

    sz = length(signal);
    counter = 1;
    nbrSound = 0;
    startSoundArray = [];
    endSoundArray = [];
    nbrSamples = 10000;
    
    while counter < sz - nbrSamples
        [tStart, tEnd] = findSound(signal(counter:sz - nbrSamples - 1), nbrSamples);
        if tStart ~= 0
            tempStart = tStart - 3*nbrSamples;
            tempEnd = tEnd + 3*nbrSamples;
            startSoundArray = [startSoundArray (counter + tempStart)];
            endSoundArray = [endSoundArray (counter + tempEnd)];
            counter = counter + tEnd;
            nbrSound = nbrSound + 1;
        else
            break;
        end
    end
    
    if ~isempty(startSoundArray) && ~isempty(endSoundArray)
        for i = 1:nbrSound
            plot(startSoundArray(i),0,'o')
            plot(endSoundArray(i),0,'o')
        end
    end
    
end