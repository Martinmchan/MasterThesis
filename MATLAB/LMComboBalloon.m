function out = LMComboBalloon(signalMatrix, nbrOfSpeakers, micMatrix, lsb, usb)
    f = 48000;
    
    tdoa = zeros(4);
    
    %Calculate the TDOA
    for i = 1:nbrOfSpeakers-1
        for j = i+1:nbrOfSpeakers
            tmp = ourAED(signalMatrix{i}, signalMatrix{j})
            tdoa(i,j) = tmp/f*343
        end
    end
    
    tdoa = (-tdoa)'+tdoa;
  
    %Initial guess
    x0 = [15.05,0.7,1]';

    %Calculate the position of the sound source using Levenberg-Marquardt
    %options.Algorithm = 'levenberg-marquardt';
    out = [];
    for i = 1:nbrOfSpeakers
        sourcePos = lsqnonlin(@ComboBalloonMyFunc,x0, lsb ,usb, [], tdoa, nbrOfSpeakers, micMatrix,i);
        out = [out; sourcePos'];
    end
end