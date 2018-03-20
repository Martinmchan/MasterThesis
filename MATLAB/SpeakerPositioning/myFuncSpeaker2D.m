function outF = myFuncSpeaker2D(param, nbrOfSpeakers, distMatrix, posMic1, posMic2)

    outF = [];
    for i = 1:nbrOfSpeakers
       for j = i+1:nbrOfSpeakers
            if i == 1
                if j ~= 2
                    func = distMatrix(i,j) - sqrt((posMic1(1) - param((j-2)*2-1))^2 + (posMic1(2) - param((j-2)*2))^2);
                    outF = [outF func];
                end
            elseif i == 2
                func = distMatrix(i,j) - sqrt((posMic2(1) - param((j-2)*2-1))^2 + (posMic2(2) - param((j-2)*2))^2);
                outF = [outF func];
            else
                func = distMatrix(i,j) - sqrt((param((i-2)*2-1) - param((j-2)*2-1))^2 + (param((i-2)*2) - param((j-2)*2))^2);
                outF = [outF func];
            end
       end 
    end
end
