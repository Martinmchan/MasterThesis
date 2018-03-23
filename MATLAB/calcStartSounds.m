function [startSoundArray, endSoundArray, nbrSound] = calcStartSounds(signal)
    
    sz = length(signal);
    counter = 1;
    nbrSound = 0;
    startSoundArray = [];
    endSoundArray = [];
    nbrSamples = 10000;
    
    while counter < sz - nbrSamples
        [tStart, tEnd] = findSound(signal(counter:sz - nbrSamples - 1), nbrSamples);
        if tStart ~= 0
            tempStart = tStart - 6*nbrSamples;
            tempEnd = tEnd + 6*nbrSamples;
            startSoundArray = [startSoundArray (counter + tempStart)];
            endSoundArray = [endSoundArray (counter + tempEnd)];
            counter = counter + tEnd;
            nbrSound = nbrSound + 1;
        else
            break;
        end
    end
end