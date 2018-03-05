function quality = ExperimentCheckSyncQuality(cameraMatrix, dist, micMatrix, nbrOfSpeakers, sVec)
%ExperimentChechSyncQuality checks the quality of the synchronization.

%Check distance
for i=2:nbrOfSpeakers
    realDist(i) = norm(cameraMatrix(1,:) - cameraMatrix(i,:)); 
end
err = norm(realDist - dist);
if err > 1
    quality(1,:) = 'bad';
elseif err < 0.5
    quality(1,:) = 'good';
else
    quality(1,:) = 'ok';
end

%Check synchronization using checkSync2
j = 2;
for i=2:nbrOfSpeakers
    if i == nbrOfSpeakers
        quality(j,:) = checkSync2(micMatrix{i}, micMatrix{2}, sVec(i), sVec(2));
    else
        quality(j,:) = checkSync2(micMatrix{i}, micMatrix{i+1}, sVec(i), sVec(i+1));
    end
    j = j+1;
end

end

