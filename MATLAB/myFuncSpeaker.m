function outF = myFuncSpeaker(param, nbrOfSpeakers, distMatrix, posMic1)

    outF = [];
    for i = 1:nbrOfSpeakers
       for j = i+1:nbrOfSpeakers
            if i == 1
                func = distMatrix(i,j) - sqrt((posMic1(1) - param((j-1)*3-2))^2 + (posMic1(2) - param((j-1)*3-1))^2 + (posMic1(3) - param((j-1)*3))^2);
                outF = [outF func];
            else
                func = distMatrix(i,j) - sqrt((param((i-1)*3-2) - param((j-1)*3-2))^2 + (param((i-1)*3-1) - param((j-1)*3-1))^2 + (param((i-1)*3) - param((j-1)*3))^2);
                outF = [outF func];
            end
       end 
    end
end

