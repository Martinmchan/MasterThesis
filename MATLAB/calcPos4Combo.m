function pos = calcPos4Combo(signalMatrix, nbrOfSpeakers, micMatrix, f, x0, lsb, usb, tdoaMethod)
    
    [comboMatrix, nbrComb] = ourMicQuads(nbrOfSpeakers);
    pointMatrix = zeros(3,nbrComb);
    
    tdoa{1} = 0;
    %Calculate the TDOA using the choosen tdoa calculater  
    for i = 1:nbrComb
        if length(tdoaMethod) == length('GCCPhat')
            if tdoaMethod == 'GCCphat'
                tdoa{1} = ourGCCphat(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(2,i)})/f*343;
                tdoa{2} = ourGCCphat(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(3,i)})/f*343;
                tdoa{3} = ourGCCphat(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(4,i)})/f*343;
            end
            
        elseif length(tdoaMethod) ==length('GCCscores')
            if tdoaMethod == 'GCCscores'
                tdoa{1} = GCCscore(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(2,i)})/f*343;
                tdoa{2} = GCCscore(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(3,i)})/f*343;
                tdoa{3} = GCCscore(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(4,i)})/f*343;
            end
        
        elseif length(tdoaMethod) == length('MovingAverage')
            if tdoaMethod == 'MovingAverage'
                tdoa{1} = ourMovingAverage(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(2,i)})/f*343;
                tdoa{2} = ourMovingAverage(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(3,i)})/f*343;
                tdoa{3} = ourMovingAverage(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(4,i)})/f*343;
            end
        
        elseif length(tdoaMethod) == length('CrossCorrelation')
            if tdoaMethod == 'CrossCorrelation'
                tdoa{1} = ourCrossCorr(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(2,i)})/f*343;
                tdoa{2} = ourCrossCorr(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(3,i)})/f*343;
                tdoa{3} = ourCrossCorr(signalMatrix{comboMatrix(1,i)}, signalMatrix{comboMatrix(4,i)})/f*343;
            end    
            
        else
            error('You have to choose one of the options');
        end       

        rDist = norm(micMatrix(comboMatrix(1,i),:) - micMatrix(comboMatrix(2,i),:));
        tdoa{1} = min(tdoa{1},rDist - 0.1);
        rDist = norm(micMatrix(comboMatrix(1,i),:) - micMatrix(comboMatrix(3,i),:));
        tdoa{2} = min(tdoa{2},rDist - 0.1);
        rDist = norm(micMatrix(comboMatrix(1,i),:) - micMatrix(comboMatrix(4,i),:));
        tdoa{3} = min(tdoa{3},rDist - 0.1);

        tempPos = lsqnonlin(@ourFunc4Combo,x0, lsb ,usb, [], tdoa, micMatrix, comboMatrix(:,i));
        
        pointMatrix(1,i) = tempPos(1,1);
        pointMatrix(2,i) = tempPos(1,2);
        pointMatrix(3,i) = tempPos(1,3);
    end
    
    xCombo = mean(pointMatrix(1,:));yCombo = mean(pointMatrix(2,:));zCombo = mean(pointMatrix(3,:));
    pos = [xCombo, yCombo, zCombo];
    
end