function [y2Synced, dist, deltaT]= ourSync2(mic1, mic2, s1, s2)
    
    N = 16;
    targetF = 4000;
    f = 48000;
    freq_index = round(targetF/f*N) + 1;

    y1 = mic1(s1);
    y2 = mic2(s1);
    L = length(y1);
    play1a = 0;
    cap1b = 0;
    for i = 1:N:L-100
        dft_data = abs(goertzel(y1(i:i+N),freq_index));
        if dft_data >0.1
            play1a = i;
            break;
        end
    end
    
    for i = 1:N:L-100
        dft_data = abs(goertzel(y2(i:i+N),freq_index));
        if dft_data >0.1
            cap1b= i;
            break;
        end
    end


    y1 = mic1(s2);
    y2 = mic2(s2);
    L = length(y1);
    play2b = 0;
    cap2a = 0;
    for i = 1:N:L-100
        dft_data = abs(goertzel(y1(i:i+N),freq_index));
        if dft_data >0.1
            cap2a = i;
            break;
        end
    end
    
    for i = 1:N:L-100
        dft_data = abs(goertzel(y2(i:i+N),freq_index));
        if dft_data >0.1
            play2b = i;
            break;
        end
    end
    
    deltaT = round(((cap1b+play2b)-(play1a+cap2a))/2);
    dist = abs((((cap2a + cap1b) - (play1a + play2b))/2))*343/f;
    
    if deltaT < 0
        y2Synced = [zeros(1-deltaT,1);mic2];
    elseif deltaT > 0
        y2Synced = mic2(deltaT:end);
    else
        y2Synced = mic2;
    end
    
end