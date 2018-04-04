function outF = ourFuncAll(param, tdoa, nbrOfSpeakers, micMatrix, nbrTDOA, allMatrix)
x = param(1);
y = param(2);
z = param(3);

outF = [];
for i = 1:nbrTDOA
    func = tdoa{i} - sqrt((x-micMatrix(allMatrix(i,1),1)).^2 + (y-micMatrix(allMatrix(i,1),2)).^2 + (z-micMatrix(allMatrix(i,1),3)).^2) + sqrt((x-micMatrix(allMatrix(i,2),1)).^2 + (y-micMatrix(allMatrix(i,2),2)).^2 + (z-micMatrix(allMatrix(i,2),3)).^2);
    outF = [outF func];
end

end
