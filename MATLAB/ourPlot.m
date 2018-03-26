function ourPlot(micMatrix, nbrOfSpeakers, positionMatrix, lsb, usb)
    plotSpeakers(micMatrix, nbrOfSpeakers, lsb, usb);
    hold on
    for i = 1:length(positionMatrix(:,1))
        scatter3(positionMatrix(i,1), positionMatrix(i,2), positionMatrix(i,3), '*')
    end
end