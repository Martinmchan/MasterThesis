function y2 = knownSync(y1,y2,s1,deltaS)


deltaT = ourGccphat(y1(s1),y2(s1));
deltaFrame = deltaS*48000/343;


if deltaT > 0
    y2 = [zeros(deltaT-deltaFrame,1);y2];
elseif deltaT < 0
    y2 = y2(-deltaT+deltaFrame:end);
else
    y2 = 0;
end


end