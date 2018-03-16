close all;
clear all;

%Initialize speaker position, number of speakers and the names of the files
micMatrix = [0 0 1.7; 0.9 0 0.1; 1.83 0 0.5; 0 2.4 0.1; 1.83 2.40 1.8; 0 4.45 1.1; 0.9 4.45 0.1; 1.83 4.45 1.08];
nbrOfSpeakers = 8;
microphones = {'mic1_0315_2.wav';'mic2_0315_2.wav';'mic3_0315_2.wav';'mic4_0315_2.wav';'mic5_0315_2.wav';'mic6_0315_2.wav';'mic7_0315_2.wav';'mic8_0315_2.wav'};


%Reads the data and plots them
signalMatrix = [];
f=0;
for i = 1:nbrOfSpeakers
    [mic, f] = audioread(microphones{i});
    mic = mic - mean(mic);
    mic = ourFilter(mic,1,60);
    signalMatrix{i} = mic;
    hold on
    plot(mic);
end

%Syncs all the microphones using mic1 as master, then plot the result.
%Distance between the microphones are also shown as an indicator of how
%good the sync was.
j=200001;
figure;
plot(signalMatrix{1});
sVec{1} = 1:200000;
for i = 2:nbrOfSpeakers
   s = j:j+200000;
   [mic, distance, ~] = ourSync(signalMatrix{1}, signalMatrix{i}, sVec{1}, s);
   signalMatrix{i} = mic;
   sVec{i} = s;
   j = j+200000;
   hold on
   plot(signalMatrix{i});
   dist(i) = distance;
end


distMatrix = makeDistMatrix(nbrOfSpeakers, signalMatrix, sVec);

quality = ManyCheckSyncQuality(micMatrix, dist, signalMatrix, nbrOfSpeakers, sVec);

%%
posMic1 = [0 0 1.70];
lsbSpeaker = ones(1,(nbrOfSpeakers-1)*3)-2;
usbSpeaker = ones(1,(nbrOfSpeakers-1)*3)*5;

lsb = [-1,-1,-1];
usb = [3,5,3];

calcMicMatrix = calculateMicMatrix(nbrOfSpeakers,distMatrix, posMic1, lsbSpeaker, usbSpeaker);

%Scatterplots them.
plotSpeakers(micMatrix, nbrOfSpeakers, lsb, usb);
hold on
for i = 1:nbrOfSpeakers-1
    a = i+1; b = num2str(a); c = cellstr(b);
    dx = 0.2; dy = 0.2; dz = 0.2;
    text(calcMicMatrix(i,1)+dx, calcMicMatrix(i,2)+dy, calcMicMatrix(i,3)+dz, c);
    scatter3(calcMicMatrix(i,1),calcMicMatrix(i,2),calcMicMatrix(i,3),'*b')
end


