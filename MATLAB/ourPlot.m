function ourPlot(micMatrix, nbrOfSpeakers, positionMatrix, lsb, usb, numbering)
    plotSpeakers(micMatrix, nbrOfSpeakers, lsb, usb);
    hold on
    for i = 1:length(positionMatrix(:,1))
<<<<<<< HEAD
        scatter3(positionMatrix(i,1), positionMatrix(i,2), positionMatrix(i,3), '*k')
=======
        
        scatter3(positionMatrix(i,1), positionMatrix(i,2), positionMatrix(i,3), '*')
>>>>>>> be865fa19373327c71ac914aa076a081ed8f0d31
    end
    if numbering
        a = [1:length(positionMatrix(:,1))]'; b = num2str(a); c = cellstr(b);
        dx = 0.2; dy = 0.2; dz = 0.2;
        text(positionMatrix(:,1)+dx, positionMatrix(:,2)+dy, positionMatrix(:,3)+dz, c);
    end
end
