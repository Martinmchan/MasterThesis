function outF = ComboBalloonMyFunc(param, tdoa, nbrOfSpeakers, xyz, speaker)
x = param(1);
y = param(2);
z = param(3);
outF = [];
for i = 1:nbrOfSpeakers
    if i ~= speaker
        func = tdoa(speaker,i) - sqrt((x-xyz(speaker,1)).^2 + (y-xyz(speaker,2)).^2 + (z-xyz(speaker,3)).^2) + sqrt((x-xyz(i,1)).^2 + (y-xyz(i,2)).^2 + (z-xyz(i,3)).^2);
        outF = [outF func];
    end
end

end
