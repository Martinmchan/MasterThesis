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


fileID = fopen('./100ComplexSyncedPos.txt');
results = textscan(fileID,'%f %f %f %f', 'delimiter', '\t','collectoutput',true);
results = results{1};
fclose(fileID);


%Plots the results
numbering = 0;
ourPlot(micMatrix, nbrOfSpeakers, results(:,1:3), lsb, usb, numbering)

scatter3(5, 1.6, 2,100,'or','MarkerFaceColor','r')
grid off;
