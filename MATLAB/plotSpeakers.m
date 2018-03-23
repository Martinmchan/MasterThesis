function plotSpeakers(micMatrix, nbrOfSpeakers, lb, ub)
%scatterPlot Plots the microphones and the sound source.
%   INPUT
%       xyzMic - a matrix with the coordinates for the four microphones
%       xS, yS, zS - the coordinates for the sound source

    micX = micMatrix(:,1); micY = micMatrix(:,2); micZ = micMatrix(:,3);
    figure;
    scatter3(micX, micY, micZ,100,'sr','MarkerFaceColor','r')
    a = [1:nbrOfSpeakers]'; b = num2str(a); c = cellstr(b);
    dx = 0.2; dy = 0.2; dz = 0.2;
    text(micX+dx, micY+dy, micZ+dz, c);
    set(gca,'Xlim',[min(lb), max(ub)], 'YLim', [min(lb), max(ub)], 'Zlim', [0, 3])

end