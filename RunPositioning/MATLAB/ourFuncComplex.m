function outF = ourFuncComplex(param, tdoa, nbrOfSpeakers, micMatrix, amountOfSound)
    latencies(1:nbrOfSpeakers-1) = param(1:nbrOfSpeakers-1);
    
    posMatrix = zeros(amountOfSound,3);
    
    paramcounter = nbrOfSpeakers;
    for i = 1:amountOfSound
        for j = 1:3
            posMatrix(i,j) = param(paramcounter);
            paramcounter = paramcounter + 1;
        end
    end

    outF = [];
    index = 1;
    for i = 1:amountOfSound
        for j = 2:nbrOfSpeakers
            func = tdoa{index} + latencies(j - 1) - sqrt((posMatrix(i,1)-micMatrix(1,1)).^2 + (posMatrix(i,2)-micMatrix(1,2)).^2 + (posMatrix(i,3)-micMatrix(1,3)).^2) + sqrt((posMatrix(i,1)-micMatrix(j,1)).^2 + (posMatrix(i,2)-micMatrix(j,2)).^2 + (posMatrix(i,3)-micMatrix(j,3)).^2);
            outF = [outF func];
            index = index + 1;
        end
    end
end