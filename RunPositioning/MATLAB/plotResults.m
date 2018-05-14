close all;
clear all;

fileID = fopen('../configuration.txt');
confFile = textscan(fileID,'%s', 'delimiter', '\t','collectoutput',true);
confFile=confFile{1};
fclose(fileID);
micMatrix = str2num(confFile{end});
nbrOfSpeakers = length(micMatrix(:,1));
lsb = [-1,-1,1];
usb = [max(micMatrix(:,1)) + 1,max(micMatrix(:,2)) + 1, 2];


fileID = fopen('./100GStreamer.txt');
results = textscan(fileID,'%f %f %f %f', 'delimiter', '\t','collectoutput',true);
results = results{1};
fclose(fileID);
resultsX = results(:,2);
resultsY = results(:,1);
results = [resultsX resultsY results(:,3)];

%Plots the results
numbering = 0;
ourPlot(micMatrix, nbrOfSpeakers, results(:,1:3), lsb, usb, numbering)

scatter3(1.6, 5, 2,100,'or','MarkerFaceColor','r')
grid off;

%Calculate the mean error
for i =1:length(results)
    errorMatrix(i) = norm(results(i,1:2) - [1.6 5]);
end

meanError = mean(errorMatrix);
