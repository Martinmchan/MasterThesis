function outF = SPFunc(param, nbrOfSpeakers, distMatrix, posMic1)

outF = [];
out1 = dist(1,2) - sqrt((posMic1(1)-param(1))^2 + (posMic1(2)-param(2))^2 + (posMic1(3)-param(3))^2);


    func = tdo - sqrt((x-micMatrix(1,1)).^2 + (y-micMatrix(1,2)).^2 + (z-micMatrix(1,3)).^2) + sqrt((x-micMatrix(i,1)).^2 + (y-micMatrix(i,2)).^2 + (z-micMatrix(i,3)).^2);
    outF = [outF func];


end

