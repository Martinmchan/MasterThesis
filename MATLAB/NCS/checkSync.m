function quality = checkSync(cameraMatrix, dist12, dist13, dist14)
    realDist12 = norm(cameraMatrix(1,:)-cameraMatrix(2,:));
    realDist13 = norm(cameraMatrix(1,:)-cameraMatrix(3,:));
    realDist14 = norm(cameraMatrix(1,:)-cameraMatrix(4,:));

    err = norm([realDist12, realDist13, realDist14] - [dist12, dist13, dist14]);
    
    if err > 1
        quality = 'bad';
    elseif err < 0.5
        quality = 'good';
    else
        quality = 'ok';
    end

end