function y2 = ourSync2(y2, deltaT)
    
    if deltaT > 0
        y2 = [zeros(deltaT,1);y2];
    elseif deltaT < 0
        y2 = y2(-deltaT:end);
    else
        y2 = 0;
    end

end