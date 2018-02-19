function deltaS = calcDist(mic1,mic2,s1,s2)
    N = 16;
    targetF = 4000;
    f = 48000;
    freq_index = round(targetF/f*N) + 1;

    y1 = mic1(s1);
    y2 = mic2(s1);
    L = length(y1);
    index1 = 0;
    index2 = 0;
    
    for i = 1:N:L-100
        dft_data = abs(goertzel(y1(i:i+N),freq_index));
        if dft_data >0.1
            index1 = i;
            break;
        end
    end
    for i = 1:N:L-100
        dft_data = abs(goertzel(y2(i:i+N),freq_index));
        if dft_data >0.1
            index2 = i;
            break;
        end
    end
    
    delta1 = index2-index1;

    y1 = mic1(s2);
    y2 = mic2(s2);
    L = length(y1);
    index1 = 0;
    index2 = 0;
    for i = 1:N:L-100
        dft_data = abs(goertzel(y1(i:i+N),freq_index));
        if dft_data >0.1
            index1 = i;
            break;
        end
    end
    for i = 1:N:L-100
        dft_data = abs(goertzel(y2(i:i+N),freq_index));
        if dft_data >0.1
            index2 = i;
            break;
        end
    end
    delta2 = index1-index2;
   
%     myPlot = [];
%     for i = 1:N:L-100
%         dft_data = abs(goertzel(y1(i:i+N),freq_index));
%         myPlot = [myPlot dft_data];
%     end
%     
%     figure
%     plot(myPlot)

    deltaS = 343/f*(delta1 + delta2)/2;
    
end