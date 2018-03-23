function pointMatrix = LMCombo(signalMatrix, nbrOfSpeakers, micMatrix, lsb, usb)
    f = 48000;
    [comboMatrix, nbrComb] = ourMicQuads(nbrOfSpeakers);
    pointMatrix = zeros(3,nbrComb);
    x0 = [1.05,0.7,1]';
    for i = 1:nbrComb
%         tdoa1 = ourGccphat(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(2,i)})/f*343;
%         tdoa2 = ourGccphat(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(3,i)})/f*343;
%         tdoa3 = ourGccphat(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(4,i)})/f*343;
%         
        tdoa1 = balloon(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(2,i)})/f*343;
        tdoa2 = balloon(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(3,i)})/f*343;
        tdoa3 = balloon(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(4,i)})/f*343;
        
        xP = lsqnonlin(@myFunc,x0, lsb ,usb, [], tdoa1, tdoa2, tdoa3, micMatrix);
        
        pointMatrix(1,i) = xP(1,1);
        pointMatrix(2,i) = xP(2,1);
        pointMatrix(3,i) = xP(3,1);
    end
   

end
