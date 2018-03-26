function pos = calcPosAll(signalMatrix, nbrOfSpeakers, micMatrix, f, x0, lsb, usb, tdoaMethod)
    nbrTDOA = sum(1:nbrOfSpeakers-1);
    
    allMatrix = zeros(nbrTDOA,2);
    counter = 1;
    for i = 1:nbrOfSpeakers - 1
        for j = i+1:nbrOfSpeakers
            allMatrix(counter, 1) = i;
            allMatrix(counter, 2) = j;
            counter = counter + 1;
        end
    end

    %Calculate the TDOA using the choosen tdoa calculater
    if length(tdoaMethod) == length('GCCPhat')
        if tdoaMethod == 'GCCphat'
            for i=1:nbrTDOA
                tmp = ourGCCphat(signalMatrix{allMatrix(i,1)}, signalMatrix{allMatrix(i,2)});
                tdoa{i} = tmp/f*343;
            end
        else
            error('You have to choose one of the options');
        end
        
    elseif length(tdoaMethod) ==length('GCCscores')
        if tdoaMethod == 'GCCscores'
            for i=1:nbrTDOA
                tmp = ourGCCscore(signalMatrix{allMatrix(i,1)}, signalMatrix{allMatrix(i,2)});
                tdoa{i} = tmp/f*343;
            end
        else
            error('You have to choose one of the options');
        end
        
    elseif length(tdoaMethod) == length('MovingAverage')
        if tdoaMethod == 'MovingAverage'
           for i=1:nbrTDOA
                tmp = ourMovingAverage(signalMatrix{allMatrix(i,1)}, signalMatrix{allMatrix(i,2)});
                tdoa{i} = tmp/f*343;
           end
        else
            error('You have to choose one of the options');
        end
    else
        error('You have to choose one of the options');
    end

    %Calculate the position of the sound source using Levenberg-Marquardt
    %options.Algorithm = 'levenberg-marquardt';
    pos = lsqnonlin(@ourFuncAll,x0, lsb ,usb, [], tdoa, nbrOfSpeakers, micMatrix, nbrTDOA, allMatrix);
end