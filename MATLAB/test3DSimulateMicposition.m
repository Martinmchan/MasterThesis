close all;
clear all;

%Initialize speaker position, number of speakers and the names of the files
micMatrix = [0 0 1.7; 0.9 0 0.1; 1.83 0 0.5; 0 2.4 0.1; 1.83 2.40 1.8; 0 4.45 1.1];
nbrOfSpeakers = 6;

distMatrix = zeros(nbrOfSpeakers);
for i = 1:nbrOfSpeakers
    for j = i+1:nbrOfSpeakers 
        distMatrix(i,j) = norm(micMatrix(i,:) - micMatrix(j,:));
    end
end

distMatrix = distMatrix+distMatrix';

posMic1 = [0 0 1.70];
lsbSpeaker = ones(1,(nbrOfSpeakers-1)*3)-2;
usbSpeaker = ones(1,(nbrOfSpeakers-1)*3)*5;

lsb = [-1,-1,-1];
usb = [3,5,3];

calcMicMatrix = calculateMicMatrix(nbrOfSpeakers,distMatrix, posMic1, lsb, usb);

%Scatterplots them.
plotSpeakers(micMatrix, nbrOfSpeakers, lsb, usb);
hold on
for i = 1:nbrOfSpeakers-1
    a = i+1; b = num2str(a); c = cellstr(b);
    dx = 0.2; dy = 0.2; dz = 0.2;
    text(calcMicMatrix(i,1)+dx, calcMicMatrix(i,2)+dy, calcMicMatrix(i,3)+dz, c);
    scatter3(calcMicMatrix(i,1),calcMicMatrix(i,2),calcMicMatrix(i,3),'*b')
end
