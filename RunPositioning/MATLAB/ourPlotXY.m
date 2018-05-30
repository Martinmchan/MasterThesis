function ourPlotXY(micMatrix, nbrOfSpeakers, positionMatrix, lsb, usb, numbering)
    plotSpeakersXY(micMatrix, nbrOfSpeakers, lsb, usb);
    hold on
    for i = 1:length(positionMatrix(:,1))
        plot(positionMatrix(i,1), positionMatrix(i,2), '*b')
    end
    if numbering
        a = [1:length(positionMatrix(:,1))]'; b = num2str(a); c = cellstr(b);
        dx = 0.2; dy = 0.2;
        text(positionMatrix(:,1)+dx, positionMatrix(:,2)+dy, c);
    end
end