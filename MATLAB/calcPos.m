function [xS, yS, zS] = calcPos(signalMatrix, nbrOfSpeakers, micMatrix, f, x0, lsb, usb, tdoa)
    
    %Calculate the TDOA using the choosen tdoa calculater
    if length(tdoa) == length('GCCPhat')
        if tdoa == 'GCCPhat'
            for i=2:nbrOfSpeakers
                tmp = ourGCCphat(signalMatrix{1}, signalMatrix{i});
                tdoa{i} = tmp/f*343;
            end
        end
        
    elseif length(toda) ==length('GCCScore')
        if tdoa == 'GCCScore'
            for i=2:nbrOfSpeakers
                tmp = ourGCCscore(signalMatrix{1}, signalMatrix{i});
                tdoa{i} = tmp/f*343;
            end
        end
        
    elseif length(tdoa) == length('balloon')
        if tdoa == 'MovingAverage'
           for i=2:nbrOfSpeakers
                tmp = ourMovingAverage(signalMatrix{1}, signalMatrix{i});
                tdoa{i} = tmp/f*343;
            end
        end
    else
        error('You have to choose one of the options');
    end
  
    %Initial guess
    x0 = [1.05,0.7,1]';

    %Calculate the position of the sound source using Levenberg-Marquardt
    %options.Algorithm = 'levenberg-marquardt';
    xP = lsqnonlin(@ourFunc,x0, lsb ,usb, [], tdoa, nbrOfSpeakers, micMatrix);
    xS = xP(1,1); yS = xP(2,1); zS = xP(3,1);

end