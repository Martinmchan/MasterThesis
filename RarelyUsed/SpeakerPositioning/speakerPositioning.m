clear all
close all

micMatrix = [0 0; 1 0; 0 1; 1 1];
posMic1 = micMatrix(1,:);
nbrOfSpeakers = length(micMatrix(:,1));

calculateMicMatrix = calcMicMatrix(nbrOfSpeakers, micMatrix, posMic1);