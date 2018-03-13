function y2 = ourSync(y1,y2,s1,s2)

    mic1 = y1(s1);
    mic2 = y2(s1);
    gcctdoa1 = ourGccphat(mic1, mic2);

    mic1 = y1(s2);
    mic2 = y2(s2);
    gcctdoa2 = ourGccphat(mic1,mic2);

    gcctdoa = floor((gcctdoa1 - gcctdoa2)/2);

%     if gcctdoa < 0
%         x1 = (1-gcctdoa:200000);
%         x2 = (1:200000+gcctdoa);
%     elseif gcctdoa > 0
%         x1 = (1:200000-gcctdoa);
%         x2 = (gcctdoa:200000);
%     end
%     
    
    if gcctdoa < 0
        x1 = (s1(1)-gcctdoa:s1(end));
        x2 = (s1(1):s1(end)+gcctdoa);
    elseif gcctdoa > 0
        x1 = (s1(1):s1(end)-gcctdoa);
        x2 = (s1(1)+gcctdoa:s1(end));
    end


    mic1 = y1(x2);
    mic2 = y2(x1);
    deltaT = ourGccphat(mic1,mic2)

    if deltaT > 0
        y2 = [zeros(deltaT,1);y2];
    elseif deltaT < 0
        y2 = y2(1-deltaT:end);
    else
        y2 = y2;
    end


end
