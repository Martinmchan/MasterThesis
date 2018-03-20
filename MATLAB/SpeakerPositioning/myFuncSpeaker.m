function outF = myFuncSpeaker(param, nbrOfSpeakers, distMatrix, posMic1, posMic2, posMic3)

    outF = [];
    for i = 1:nbrOfSpeakers
       for j = i+1:nbrOfSpeakers
            if i == 1
                if j ~= 2
                    if j ~= 3
                        func = distMatrix(i,j) - sqrt((posMic1(1) - param((j-3)*3-2))^2 + (posMic1(2) - param((j-3)*3-1))^2 + (posMic1(3) - param((j-3)*3))^2);
                        outF = [outF func];
                    end
                end
            elseif i == 2    
                if j ~= 3
                    func = distMatrix(i,j) - sqrt((posMic2(1) - param((j-3)*3-2))^2 + (posMic2(2) - param((j-3)*3-1))^2 + (posMic2(3) - param((j-3)*3))^2);
                    outF = [outF func];
                end
            elseif i == 3
                func = distMatrix(i,j) - sqrt((posMic3(1) - param((j-3)*3-2))^2 + (posMic3(2) - param((j-3)*3-1))^2 + (posMic3(3) - param((j-3)*3))^2);
                outF = [outF func];
            else
                func = distMatrix(i,j) - sqrt((param((i-3)*3-2) - param((j-3)*3-2))^2 + (param((i-3)*3-1) - param((j-3)*3-1))^2 + (param((i-3)*3) - param((j-3)*3))^2);
                outF = [outF func];
            end
       end 
    end
end

