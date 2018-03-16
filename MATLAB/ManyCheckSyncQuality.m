function quality = ManyCheckSyncQuality(micMatrix, dist, signalMatrix, nbrOfSpeakers, sVec)
%ExperimentChechSyncQuality checks the quality of the synchronization.

%Check distance
for i=2:nbrOfSpeakers
    realDist(i) = norm(micMatrix(1,:) - micMatrix(i,:)); 
end

err = [];
for i = 1:nbrOfSpeakers
    tempErr = abs(realDist(i)-dist(i));
    err = [err tempErr];
end

err = mean([err]);
quality{1} = err;


%Check synchronization using checkSync2
j = 2;
for i=2:nbrOfSpeakers
    if i == nbrOfSpeakers
        [~, ~, quality{j}] = ourSync(signalMatrix{i}, signalMatrix{2}, sVec{i}, sVec{2});
    else
        [~, ~, quality{j}] = ourSync(signalMatrix{i}, signalMatrix{i+1}, sVec{i}, sVec{i+1});
    end
    j = j+1;
end

end

