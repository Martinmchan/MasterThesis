function quality = ManyCheckSyncQuality(micMatrix, dist, signalMatrix, nbrOfSpeakers, sVec)
%ExperimentChechSyncQuality checks the quality of the synchronization.

%Check distance
for i=2:nbrOfSpeakers
    realDist(i) = norm(micMatrix(1,:) - micMatrix(i,:)); 
end
err = norm(realDist - dist);
if err > 1
    quality{1} = 'bad';
elseif err < 0.5
    quality{1} = 'good';
else
    quality{1} = 'ok';
end

%Check synchronization using checkSync2
j = 2;
for i=2:nbrOfSpeakers
    if i == nbrOfSpeakers
        quality{j} = checkSync2(signalMatrix{i}, signalMatrix{2}, sVec(i), sVec(2));
    else
        quality{j} = checkSync2(signalMatrix{i}, signalMatrix{i+1}, sVec(i), sVec(i+1));
    end
    j = j+1;
end

end

