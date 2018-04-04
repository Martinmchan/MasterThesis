function [theMatrix, nbrComb] = ourMicQuads(nbrOfSpeakers)
    nbrComb = factorial(nbrOfSpeakers)/(factorial(4)*factorial(nbrOfSpeakers-4));
    theMatrix = zeros(4,nbrComb);
    counter = 1;
    for i = 1:nbrOfSpeakers-3
        for j = i+1:nbrOfSpeakers-2
            for k = j+1:nbrOfSpeakers-1
                for m = k+1:nbrOfSpeakers
                    if length([i j k m]) == length(unique([i j k m]))
                        theMatrix(1,counter) = i;
                        theMatrix(2,counter) = j;
                        theMatrix(3,counter) = k;
                        theMatrix(4,counter) = m;
                        counter = counter + 1;
                    end
                end
            end
        end
    end
end