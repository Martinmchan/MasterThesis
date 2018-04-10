function deltaT = newSync(mic1, mic2,s)
    
    N = 16;
    targetF = 4000;
    f = 48000;
    freq_index = round(targetF/f*N) + 1;

    y1 = mic1(s);
    y2 = mic2(s);
    L = length(y1);
    
    t1 = 0;
    t2 = 0;
   
    for i = 1:N:L-100
        dft_data = abs(goertzel(y1(i:i+N),freq_index));
        if dft_data >0.3
            t1 = i;
            break;
        end
    end
    for i = 1:N:L-100
        dft_data = abs(goertzel(y2(i:i+N),freq_index));
        if dft_data >0.3
            t2 = i;
            break;
        end
    end


    deltaT = t1 - t2;
   
end