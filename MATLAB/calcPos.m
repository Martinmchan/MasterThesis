function xPos = calcPos(signalMatrix, nbrOfSpeakers, micMatrix, f, x0, lsb, usb, tdoaMethod)
    tdoa{1} = 0;
    %Calculate the TDOA using the choosen tdoa calculater
    if length(tdoaMethod) == length('GCCPhat')
        if tdoaMethod == 'GCCphat'
            for i=2:nbrOfSpeakers
                tmp = ourGCCphat(signalMatrix{1}, signalMatrix{i});
                tdoa{i} = tmp/f*343;
            end
        end
        
    elseif length(tdoaMethod) ==length('GCCscores')
        if tdoaMethod == 'GCCscores'
            for i=2:nbrOfSpeakers
                tmp = ourGCCscore(signalMatrix{1}, signalMatrix{i});
                tdoa{i} = tmp/f*343;
            end
        end
        
    elseif length(tdoaMethod) == length('MovingAverage')
        if tdoaMethod == 'MovingAverage'
           for i=2:nbrOfSpeakers
                tmp = ourMovingAverage(signalMatrix{1}, signalMatrix{i});
                tdoa{i} = tmp/f*343;
            end
        end
    else
        error('You have to choose one of the options');
    end

    %Calculate the position of the sound source using Levenberg-Marquardt
    %options.Algorithm = 'levenberg-marquardt';
    xPos = lsqnonlin(@ourFunc,x0, lsb ,usb, [], tdoa, nbrOfSpeakers, micMatrix);

end