function [tStart, tEnd] = findSound(signal, nbrSamples)
    sz = length(signal);

    signal = abs(signal);

    multStart = 10;
    multEnd = 1.2;
    avg = mean(signal(1:nbrSamples));
    tempAvg = avg;
    
    %Find the time when the sound starts
    tStart = 0;
    for i = 1:sz - nbrSamples
        if signal(i + nbrSamples) > multStart*tempAvg
            tStart = i + nbrSamples;
            break;
        else
            tempAvg = tempAvg - signal(i)/nbrSamples + signal(i + nbrSamples)/nbrSamples;
        end  
    end
    
    %Find the time for silence again if sound was found
    if tStart ~= 0
        tEnd = 0;
        tempAvg = mean(signal(tStart:tStart + nbrSamples - 1));
        for i = tStart:sz - nbrSamples
           if  tempAvg < multEnd*avg
               tEnd = i + nbrSamples;
               break;
           else
               tempAvg = tempAvg - signal(i)/nbrSamples + signal(i + nbrSamples)/nbrSamples;
           end    
        end
    else
        tEnd = 0;
    end
end
