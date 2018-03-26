function outF = ourFunc(param, tdoa, nbrOfSpeakers, micMatrix)
x = param(1);
y = param(2);
z = param(3);
outF = [];
for i = 2:nbrOfSpeakers
    func = tdoa{i} - sqrt((x-micMatrix(1,1)).^2 + (y-micMatrix(1,2)).^2 + (z-micMatrix(1,3)).^2) + sqrt((x-micMatrix(i,1)).^2 + (y-micMatrix(i,2)).^2 + (z-micMatrix(i,3)).^2);
    outF = [outF func];
end

end

