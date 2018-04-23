function syncedMatrix = ourCalibrate(signalMatrix, nbrOfSpeakers, micMatrix)
    
    for i = 2:nbrOfSpeakers
        realTDOA = round(-norm(micMatrix(1,:) - micMatrix(i,:))*48000/343 + 30);
        ourTDOA = ourMovingAverage(signalMatrix{1}, signalMatrix{i});
        
        %ratio = norm(micMatrix(1,:) - micMatrix(i,:));
        %correlationOfTDOA = abs((ratio - 1)*0.02*(realTDOA-ourTDOA));
        %ourTDOA = round(ourTDOA - correlationOfTDOA);
        
        if realTDOA < ourTDOA
           syncedMatrix{i} = [zeros(-(realTDOA-ourTDOA),1); signalMatrix{i}];
        elseif realTDOA > ourTDOA
            syncedMatrix{i} = signalMatrix{i}(-(ourTDOA-realTDOA):end);
        else
            syncedMatrix{i} = signalMatrix{i};
        end
        
    end
        
      syncedMatrix{1} = signalMatrix{1};
      

end

