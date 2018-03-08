function scatterPlot(xyzMic, xS, yS, zS, lb, ub)
%scatterPlot Plots the microphones and the sound source.
%   INPUT
%       xyzMic - a matrix with the coordinates for the four microphones
%       xS, yS, zS - the coordinates for the sound source

    micX = xyzMic(:,1);
    micY = xyzMic(:,2);
    micZ = xyzMic(:,3);
    figure
    scatter3(micX, micY, micZ,100,'sr','MarkerFaceColor','r')
    a = [1:4]'; b = num2str(a); c = cellstr(b);
    dx = 0.2; dy = 0.2; dz = 0.2;
    text(micX+dx, micY+dy, micZ+dz, c);
    set(gca,'Xlim',[lb(1), ub(1)], 'YLim', [lb(2), ub(2)], 'Zlim', [lb(3), ub(3)])
    hold on
    scatter3(xS,yS,zS,'*b','MarkerFaceColor','g')

end