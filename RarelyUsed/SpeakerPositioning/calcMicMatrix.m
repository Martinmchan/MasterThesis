function calculatedMicMatrix = calcMicMatrix(nbrOfSpeakers, micMatrix, posMic1)

    errorSize = 0.2;
    
    distMatrix = zeros(nbrOfSpeakers)
    for i = 2:nbrOfSpeakers
        for j = i+1:nbrOfSpeakers
            offSet = rand*errorSize-errorSize/2;
            dist = norm(micMatrix(i,:), micMatrix(j,:)) + offSet;
            distMatrix(i,j) = dist;
            distMatrix(j,i) = dist;
        end
    end
    

    x0 = zeros(1,2*(nbrOfSpeakers-1));
    
    pos = lsqnonlin(@SPFunc,x0, lsb ,usb, opt, tdoa, nbrOfSpeakers, micMatrix);




















end