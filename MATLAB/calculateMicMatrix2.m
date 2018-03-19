function calcMicMatrix = calculateMicMatrix2(nbrOfSpeakers,distMatrix, posMic1, lb, ub)

    %Initial guess
    x0 = ones(1,(nbrOfSpeakers-1)*3);
    %Calculate the position of the sound source using Levenberg-Marquardt
    %options.Algorithm = 'levenberg-marquardt';
    
    funTest = @(param) myFuncSpeaker(param, nbrOfSpeakers, distMatrix, posMic1); 
    pos = fsolve(funTest,x0);
   
    a = myFuncSpeaker(pos, nbrOfSpeakers, distMatrix, posMic1)

    counter = 1;
    for i = 1:nbrOfSpeakers-1
        for j = 1:3
            calcMicMatrix(i,j) = pos(counter);
            counter = counter + 1;
        end
    end
    
end