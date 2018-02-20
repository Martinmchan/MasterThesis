clear all;
close all;
micX = [0, -0.1, 2, 2];
micY = [0, 2.5, 0.5, 2.6];
micZ = [1.7, 1.7, 1.65, 1.85];
scatter3(micX, micY, micZ,100,'sr','MarkerFaceColor','r')
set(gca,'Xlim',[-0.5, 3], 'YLim', [-0.5, 3], 'Zlim', [0, 2])
hold on
scatter3(1,1,1,'*b','MarkerFaceColor','g')