close all
clear all

micMatrix = [0 0; 2 0; 0 2; 2 2; 1 3];
nbrOfSpeakers = 5;

distMatrix = zeros(nbrOfSpeakers);
for i = 1:nbrOfSpeakers
    for j = i+1:nbrOfSpeakers 
        distMatrix(i,j) = norm(micMatrix(i,:) - micMatrix(j,:));
    end
end
distMatrix = distMatrix+distMatrix';

posMic1 = [0 0];
posMic2 = [2 0];
lsbSpeaker = ones(1,(nbrOfSpeakers-2)*3)-2;
usbSpeaker = ones(1,(nbrOfSpeakers-2)*3)*5;

lsb = [-1,-1,-1];
usb = [3,5,3];

calcMicMatrix = calculateMicMatrix2D(nbrOfSpeakers,distMatrix, posMic1, posMic2);

micMatrix = [0 0 0; 2 0 0; 0 2 0; 2 2 0; 1 3 0];
calcMicMatrix(1,3) = 0;

%Scatterplots them.
plotSpeakers(micMatrix, nbrOfSpeakers, lsb, usb);
hold on
for i = 1:nbrOfSpeakers-2
    a = i+2; b = num2str(a); c = cellstr(b);
    dx = 0.2; dy = 0.2; dz = 0.2;
    text(calcMicMatrix(i,1)+dx, calcMicMatrix(i,2)+dy, calcMicMatrix(i,3)+dz, c);
    scatter3(calcMicMatrix(i,1),calcMicMatrix(i,2),calcMicMatrix(i,3),'*b')
end



