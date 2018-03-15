close all;
clear all;

%Initialize camera position, number of speakers and the names of the files
micMatrix = [0 0 1.7; 0.9 0 0.1; 1.83 0 0.5; 0 2.4 0.1; 1.83 2.40 1.8; 0 4.45 1.1; 0.9 4.45 0.1; 1.83 4.45 1.08];
nbrOfSpeakers = 8;
microphones = {'mic1_0315_11.wav';'mic2_0315_11.wav';'mic3_0315_11.wav';'mic4_0315_11.wav';'mic5_0315_11.wav';'mic6_0315_11.wav';'mic7_0315_11.wav';'mic8_0315_11.wav'};

%Reads the data and plots them
signalMatrix = [];
f=0;
for i = 1:nbrOfSpeakers
    [mic, f] = audioread(microphones{i});
    signalMatrix{i} = mic;
    hold on
    plot(mic);
end


%Syncs all the microphones using mic1 as master, then plot the result.
%Distance between the microphones are also shown as an indicator of how
%good the sync was.
j=200000;
figure;
plot(signalMatrix{1});
s1 = 1:200000;
for i = 2:nbrOfSpeakers
   s = j:j+200000;
   [mic, distance, ~] = ourSync(signalMatrix{1}, signalMatrix{i}, s1, s);
   signalMatrix{i} = mic;
   sVec(i) = j;
   j = j+200000;
   hold on
   plot(signalMatrix{i});
   dist(i) = distance;
end

quality = ManyCheckSyncQuality(micMatrix, dist, signalMatrix, nbrOfSpeakers, sVec);

%Generate the data after sync
figure;
for i = 1:nbrOfSpeakers
    signalMatrix{i} = signalMatrix{i}(j:end);
    plot(signalMatrix{i});
    hold on;
end

%%
%Choose data and generate wavfile

s = 1:3100000;

for i = 1:nbrOfSpeakers
    signalMatrix{i} = signalMatrix{i}(s);
end


audiowrite('mic1_0315_11.wav',signalMatrix{1},48000);
audiowrite('mic2_0315_11.wav',signalMatrix{2},48000);
audiowrite('mic3_0315_11.wav',signalMatrix{3},48000);
audiowrite('mic4_0315_11.wav',signalMatrix{4},48000);
audiowrite('mic5_0315_11.wav',signalMatrix{5},48000);
audiowrite('mic6_0315_11.wav',signalMatrix{6},48000);
audiowrite('mic7_0315_11.wav',signalMatrix{7},48000);
audiowrite('mic8_0315_11.wav',signalMatrix{8},48000);













