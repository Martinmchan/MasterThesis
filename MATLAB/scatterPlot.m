function scatterPlot(xyzMic, xS, yS, zS)
%scatterPlot Plots the microphones and the sound source.
%   INPUT
%       xyzMic - a matrix with the coordinates for the four microphones
%       xS, yS, zS - the coordinates for the sound source

    micX = xyzMic(:,1);
    micY = xyzMic(:,2);
    micZ = xyzMic(:,3);
    scatter3(micX, micY, micZ,100,'sr','MarkerFaceColor','r')
    set(gca,'Xlim',[-0.5, 3], 'YLim', [-0.5, 3], 'Zlim', [0, 2])
    hold on
    scatter3(xS,yS,zS,'*b','MarkerFaceColor','g')

end