function scatterPlot(xyzMic, xS, yS, zS)
%scatterPlot Plots the microphones and the sound source.
%   INPUT
%       xyzMic - a matrix with the coordinates for the four microphones
%       xS, yS, zS - the coordinates for the sound source

    micX = xyzMic(:,1)
    micY = xyzMic(:,2)
    micZ = xyzMic(:,3)
    figure
    scatter3(micX, micY, micZ,100,'sr','MarkerFaceColor','r')
    set(gca,'Xlim',[-5, 5], 'YLim', [-5, 5], 'Zlim', [-5, 5])
    hold on
    scatter3(xS,yS,zS,'*b','MarkerFaceColor','g')

end