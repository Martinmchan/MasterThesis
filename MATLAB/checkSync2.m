function quality = checkSync2(mic1,mic2, s1, s2)
[~, ~, tmp] = ourSync(mic1, mic2, s1, s2);

if abs(tmp) > 32
    quality = 'bad';
else
    quality = 'good';
end
    

end

