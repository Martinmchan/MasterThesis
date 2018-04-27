function [latencies, posMatrix, micMatrix] = ourCalibrateSpeaker(signalMatrix, nbrOfSpeakers, startSoundArray, endSoundArray, amountOfSound)
    index = 1;
    for i = 1:amountOfSound
        for j = 2:nbrOfSpeakers
            tdoa{index} = ourMovingAverage(signalMatrix{1}(startSoundArray(i):endSoundArray(i)), signalMatrix{j}(startSoundArray(i):endSoundArray(i))); 
            tdoa{index} = tdoa{index}*343/48000;
            index = index + 1;
        end
    end
    
    x0 = [];lsb = []; usb = [];
    for i = 1:3*(nbrOfSpeakers - 2)
        x0 = [x0 3];lsb = [lsb 0];usb = [usb 15];
    end
    for i = 1:nbrOfSpeakers-1
        x0 = [x0 3];lsb = [lsb -inf];usb = [usb inf];
    end
    for i = 1:3*amountOfSound
        x0 = [x0 3];lsb = [lsb -1]; usb = [usb 10];
    end
    
    opt = optimoptions('lsqnonlin','Display','off');
    solutions = lsqnonlin(@ourFuncSpeaker,x0, lsb, usb, opt, tdoa, nbrOfSpeakers, [0 0 1.2], [0 2.25 0.1], amountOfSound);

    micMatrix = zeros(nbrOfSpeakers - 2,3);
    paramcounter = 1;
    for i = 1:nbrOfSpeakers - 2
        for j = 1:3
            micMatrix(i,j) = solutions(paramcounter);
            paramcounter = paramcounter + 1;
        end
    end
    
    latencies = solutions(3*(nbrOfSpeakers-2) + 1:3*(nbrOfSpeakers-2) + nbrOfSpeakers - 1);
    
    posMatrix = zeros(amountOfSound,3);
    paramcounter = 3*(nbrOfSpeakers-2) + nbrOfSpeakers;
    for i = 1:amountOfSound
        for j = 1:3
            posMatrix(i,j) = solutions(paramcounter);
            paramcounter = paramcounter + 1;
        end
    end

end