function pos = calcPosTwice(signalMatrix, nbrOfSpeakers, micMatrix, f, x0, lsb, usb, tdoaMethod)

    pos = calcPos(signalMatrix, nbrOfSpeakers, micMatrix, f, x0, lsb, usb, tdoaMethod);
    
    for i=1:nbrOfSpeakers
        dist2speaker(i) = norm(pos - micMatrix(i,:));
    end
    
    for i =1:nbrOfSpeakers
        [~,idx] = min(dist2speaker);
        dist2speaker(idx) = 10e6;
        sortSpeaker(i) = idx;
    end
    
    pos = calcPos(signalMatrix(sortSpeaker(1:4)), 4, micMatrix(sortSpeaker(1:4),:), f, x0, lsb, usb, tdoaMethod);

end