function distMatrix = makeDistMatrix(nbrOfSpeakers, signalMatrix, sVec)
    

    distMatrix = zeros(nbrOfSpeakers);
    for i = 1:nbrOfSpeakers
       for j = i+1:nbrOfSpeakers
           [~, dist, ~] = ourSync(signalMatrix{i},signalMatrix{j},sVec{i},sVec{j});
           distMatrix(i,j) = dist;
       end 
    end
    
    distMatrix = distMatrix + distMatrix';
    
end