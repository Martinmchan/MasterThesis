function tdoa = ourMovingAverage(mic1, mic2)
    
    sz = min([length(mic1) length(mic2)]);

    mic1 = abs(mic1);
    mic2 = abs(mic2);
    
    nbrSamples = 10000;
    multP = 10;
    
    avg1 = mean(mic1(1:nbrSamples));
    avg2 = mean(mic2(1:nbrSamples));
    
    t1 = 0;
    t2 = 0;
    
    for i = 1:sz - nbrSamples
        if mic1(i + nbrSamples) > multP*avg1
            t1 = i + nbrSamples;
            break;
        else
            avg1 = avg1 - mic1(i)/nbrSamples + mic1(i + nbrSamples)/nbrSamples;
        end  
    end
        
    for i = 1:sz - nbrSamples
        if mic2(i + nbrSamples) > multP*avg2
            t2 = i + nbrSamples;
            break;
        else
            avg2 = avg2 - mic2(i)/nbrSamples + mic2(i + nbrSamples)/nbrSamples;
        end  
    end

    tdoa = t1-t2;
end
