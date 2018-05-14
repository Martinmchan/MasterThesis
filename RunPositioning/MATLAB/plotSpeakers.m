function plotSpeakers(micMatrix, nbrOfSpeakers, lsb, usb)
%scatterPlot Plots the microphones and the sound source.
%   INPUT
%       xyzMic - a matrix with the coordinates for the four microphones
%       xS, yS, zS - the coordinates for the sound source

    micX = micMatrix(:,1); micY = micMatrix(:,2); micZ = micMatrix(:,3);
    figure;
    scatter3(micX, micY, micZ,100,'sk','MarkerFaceColor','k')
    a = [1:nbrOfSpeakers]'; b = num2str(a); c = cellstr(b);
    dx = 0.2; dy = 0.2; dz = 0.2;
    text(micX+dx, micY+dy, micZ+dz, c);
    set(gca,'Xlim',[min(lsb), max(usb)], 'YLim', [min(lsb), max(usb)], 'Zlim', [0, 3])

end