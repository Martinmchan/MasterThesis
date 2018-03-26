function pos = calcPos4Combo(signalMatrix, nbrOfSpeakers, micMatrix, f, x0, lsb, usb, tdoaMethod)
    
[comboMatrix, nbrComb] = ourMicQuads(nbrOfSpeakers);
    pointMatrix = zeros(3,nbrComb);
    
    tdoa{1} = 0;
    %Calculate the TDOA using the choosen tdoa calculater  
    for i = 1:nbrComb
        if length(tdoaMethod) == length('GCCPhat')
            if tdoaMethod == 'GCCphat'
                tdoa1 = ourGCCphat(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(2,i)})/f*343;
                tdoa2 = ourGCCphat(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(3,i)})/f*343;
                tdoa3 = ourGCCphat(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(4,i)})/f*343;
            end
            
        elseif length(tdoaMethod) ==length('GCCscores')
            if tdoaMethod == 'GCCscores'
                tdoa1 = gccScore(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(2,i)})/f*343;
                tdoa2 = gccScore(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(3,i)})/f*343;
                tdoa3 = gccScore(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(4,i)})/f*343;
            end
        
        elseif length(tdoaMethod) == length('MovingAverage')
            if tdoaMethod == 'MovingAverage'
                tdoa1 = balloon(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(2,i)})/f*343;
                tdoa2 = balloon(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(3,i)})/f*343;
                tdoa3 = balloon(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(4,i)})/f*343;
            end
        else
            error('You have to choose one of the options');
        end       

        
        xPos = lsqnonlin(@myFunc,x0, lsb ,usb, [], tdoa1, tdoa2, tdoa3, micMatrix);
        
        pointMatrix(1,i) = xPos(1,1);
        pointMatrix(2,i) = xPos(2,1);
        pointMatrix(3,i) = xPos(3,1);
    end
    
    xCombo = mean(pointMatrix(1,:));yCombo = mean(pointMatrix(2,:));zCombo = mean(pointMatrix(3,:));
    pos = [xCombo, yCombo, zCombo];
    
end