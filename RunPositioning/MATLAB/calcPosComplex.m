function [latencies, posMatrix, amountOfSound] = calcPosComplex(signalMatrix, nbrOfSpeakers, micMatrix, startSoundArray, endSoundArray)
    amountOfSound = 1000;
    if nbrOfSpeakers < 5
        error('You need at least 5 speakers in order to use complexcalcpos!!!');
    elseif nbrOfSpeakers < 6
        amountOfSound = 5;
    elseif nbrOfSpeakers < 7
        amountOfSound = 3;
    else
        amountOfSound = 2;
    end
    
    index = 1;
    for i = 1:amountOfSound
        for j = 1:nbrOfSpeakers
            tdoa{index} = ourMovingAverage(signalMatrix{1}(startSoundArray(i):endSoundArray(i)), signalMatrix{j}(startSoundArray(i):endSoundArray(i))); 
            tdoa{index} = tdoa{index}*343/48000;
            index = index + 1;
        end
    end
    
    x0 = [];
    for i = 1:nbrOfSpeakers-1
        x0 = [x0 100];
    end
    for i = nbrOfSpeakers:3*amountOfSound + nbrOfSpeakers - 1
        x0 = [x0 3];
    end
    
    opt = optimoptions('lsqnonlin','Display','off');
    solutions = lsqnonlin(@ourFuncComplex,x0, [] ,[], opt, tdoa, nbrOfSpeakers, micMatrix, amountOfSound);

    latencies = solutions(1:nbrOfSpeakers-1)
    
    posMatrix = zeros(amountOfSound,3);
    
    paramcounter = nbrOfSpeakers;
    for i = 1:amountOfSound
        for j = 1:3
            posMatrix(i,j) = solutions(paramcounter);
            paramcounter = paramcounter + 1;
        end
    end

end