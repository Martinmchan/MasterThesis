function quality = checkSync2(mic1,mic2, s1, s2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[~, ~, tmp] = ourSync2(mic1, mic2, s1, s2);

if abs(tmp) > 32
    quality = 'bad';
else
    quality = 'good';
end
    

end

