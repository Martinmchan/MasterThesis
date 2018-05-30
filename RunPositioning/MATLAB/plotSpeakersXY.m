function plotSpeakersXY(micMatrix, nbrOfSpeakers, lsb, usb)
%scatterPlot Plots the microphones and the sound source.
%   INPUT
%       xyzMic - a matrix with the coordinates for the four microphones
%       xS, yS, zS - the coordinates for the sound source

    micX = micMatrix(:,1); micY = micMatrix(:,2);
    figure;
    plot(micX, micY,'k.','MarkerSize',25)
    a = [1:nbrOfSpeakers]'; b = num2str(a); c = cellstr(b);
    dx = 0.2; dy = 0.2; 
    text(micX+dx, micY+dy, c);
    set(gca,'Xlim',[min(lsb), max(usb)], 'YLim', [min(lsb), max(usb)])

end