function calcMicMatrix = calculateMicMatrix2D(nbrOfSpeakers,distMatrix, posMic1, posMic2)
    
    %Initial guess
    x0 = ones(1,(nbrOfSpeakers-1)*2);
    %x0 = [0.2 2.1 2 2.8 0.6 2.5];
    %Calculate the position of the sound source using Levenberg-Marquardt
    %options.Algorithm = 'levenberg-marquardt';
    pos = lsqnonlin(@myFuncSpeaker2D,x0, [] ,[], [], nbrOfSpeakers, distMatrix, posMic1, posMic2);
   
    
    a = myFuncSpeaker2D(pos, nbrOfSpeakers, distMatrix, posMic1, posMic2)
    %aReal = myFuncSpeaker2D([2 0 0 2 2 2 1 3], nbrOfSpeakers, distMatrix, posMic1)    
    counter = 1;
    for i = 1:nbrOfSpeakers-2
        for j = 1:2
            calcMicMatrix(i,j) = pos(counter);
            counter = counter + 1;
        end
    end
end