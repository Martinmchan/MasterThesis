function pos = calcPos(signalMatrix, nbrOfSpeakers, micMatrix, f, x0, lsb, usb, tdoaMethod)
    tdoa{1} = 0;
    %Calculate the TDOA using the choosen tdoa calculater
    if length(tdoaMethod) == length('GCCPhat')
        if tdoaMethod == 'GCCphat'
            for i=2:nbrOfSpeakers
                tmp = ourGCCphat(signalMatrix{1}, signalMatrix{i});
                tmp = tmp/f*343;
                rDist = norm(micMatrix(1,:) - micMatrix(i,:));
                tdoa{i} = min(tmp,rDist - 0.1);
            end
        else
            error('You have to choose one of the options');
        end
        
    elseif length(tdoaMethod) ==length('GCCscores')
        if tdoaMethod == 'GCCscores'
            for i=2:nbrOfSpeakers
                tmp = ourGCCscore(signalMatrix{1}, signalMatrix{i});
                tmp = tmp/f*343;
                rDist = norm(micMatrix(1,:) - micMatrix(i,:));
                tdoa{i} = min(tmp,rDist - 0.1);
            end
        else
            error('You have to choose one of the options');
        end
        
    elseif length(tdoaMethod) ==length('CrossCorrelation')
        if tdoaMethod == 'CrossCorrelation'
            for i=2:nbrOfSpeakers
                tmp = ourCrossCorr(signalMatrix{1}, signalMatrix{i});
                tmp = tmp/f*343;
                rDist = norm(micMatrix(1,:) - micMatrix(i,:));
                tdoa{i} = min(tmp,rDist - 0.1);
            end
        else
            error('You have to choose one of the options');
        end    
       
    elseif length(tdoaMethod) == length('MovingAverage')
        if tdoaMethod == 'MovingAverage'
           for i=2:nbrOfSpeakers
                tmp = ourMovingAverage(signalMatrix{1}, signalMatrix{i});
                tmp = tmp/f*343;
                rDist = norm(micMatrix(1,:) - micMatrix(i,:));
                tdoa{i} = min(tmp,rDist - 0.1);
           end
        else
            error('You have to choose one of the options');
        end
    else
        error('You have to choose one of the options');
    end

    %Calculate the position of the sound source using Levenberg-Marquardt
    %options.Algorithm = 'levenberg-marquardt';
    pos = lsqnonlin(@ourFunc,x0, lsb ,usb, [], tdoa, nbrOfSpeakers, micMatrix);

end