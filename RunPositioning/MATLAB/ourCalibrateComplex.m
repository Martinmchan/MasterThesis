function [latencies, posMatrix] = ourCalibrateComplex(signalMatrix, nbrOfSpeakers, micMatrix, startSoundArray, endSoundArray, amountOfSound)
    index = 1;
    for i = 1:amountOfSound
        for j = 2:nbrOfSpeakers
            tdoa{index} = ourMovingAverage(signalMatrix{1}(startSoundArray(i):endSoundArray(i)), signalMatrix{j}(startSoundArray(i):endSoundArray(i))); 
            tdoa{index} = tdoa{index}*343/48000;
            index = index + 1;
        end
    end
    
    x0 = [];lsb = []; usb = [];
    for i = 1:nbrOfSpeakers-1
        x0 = [x0 3];lsb = [lsb -inf];usb = [usb inf];
    end
    for i = nbrOfSpeakers:3*amountOfSound + nbrOfSpeakers - 1
        x0 = [x0 3];lsb = [lsb -1]; usb = [usb 10];
    end
    
    opt = optimoptions('lsqnonlin','Display','off');
    solutions = lsqnonlin(@ourFuncComplex,x0, lsb, usb, opt, tdoa, nbrOfSpeakers, micMatrix, amountOfSound);

    latencies = solutions(1:nbrOfSpeakers-1);
    
    posMatrix = zeros(amountOfSound,3);
    
    paramcounter = nbrOfSpeakers;
    for i = 1:amountOfSound
        for j = 1:3
            posMatrix(i,j) = solutions(paramcounter);
            paramcounter = paramcounter + 1;
        end
    end

end