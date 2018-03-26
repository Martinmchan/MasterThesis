function outF = ourFunc(param, tdoa, nbrOfSpeakers, xyz)
x = param(1);
y = param(2);
z = param(3);
outF = [];
for i = 2:nbrOfSpeakers
    func = tdoa{i} - sqrt((x-xyz(1,1)).^2 + (y-xyz(1,2)).^2 + (z-xyz(1,3)).^2) + sqrt((x-xyz(i,1)).^2 + (y-xyz(i,2)).^2 + (z-xyz(i,3)).^2);
    outF = [outF func];
end

end

