function outF = ourFuncSpeaker(param, tdoa, nbrOfSpeakers, micPosition1, micPosition2, amountOfSound)
    
    micMatrix = zeros(nbrOfSpeakers - 2 , 3);
    paramcounter = 1;
    for i = 1:nbrOfSpeakers - 2
        for j = 1:3
            micMatrix(i,j) = param(paramcounter);
            paramcounter = paramcounter + 1;
        end
    end
    
    latencies(1:nbrOfSpeakers-1) = param(3*(nbrOfSpeakers-2) + 1:3*(nbrOfSpeakers-2) + nbrOfSpeakers - 1);
    
    posMatrix = zeros(amountOfSound,3);
    paramcounter = 3*(nbrOfSpeakers-2) + nbrOfSpeakers;
    for i = 1:amountOfSound
        for j = 1:3
            posMatrix(i,j) = param(paramcounter);
            paramcounter = paramcounter + 1;
        end
    end
    
    outF = [];
    index = 1;
    for i = 1:amountOfSound
        for j = 1:nbrOfSpeakers - 1
            if j == 1
                func = tdoa{index} + latencies(j) - sqrt((posMatrix(i,1)-micPosition1(1)).^2 + (posMatrix(i,2)-micPosition1(2)).^2 + (posMatrix(i,3)-micPosition1(3)).^2) + sqrt((posMatrix(i,1)-micPosition2(1)).^2 + (posMatrix(i,2)-micPosition2(2)).^2 + (posMatrix(i,3)-micPosition2(3)).^2);
                outF = [outF func];
                index = index + 1;
            else
                func = tdoa{index} + latencies(j) - sqrt((posMatrix(i,1)-micPosition1(1)).^2 + (posMatrix(i,2)-micPosition1(2)).^2 + (posMatrix(i,3)-micPosition1(3)).^2) + sqrt((posMatrix(i,1)-micMatrix(j-1,1)).^2 + (posMatrix(i,2)-micMatrix(j-1,2)).^2 + (posMatrix(i,3)-micMatrix(j-1,3)).^2);
                outF = [outF func];
                index = index + 1;
        end
    end
end