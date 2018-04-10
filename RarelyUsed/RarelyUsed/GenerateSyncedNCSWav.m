close all;
clear all;

%Initialize camera position, number of speakers and the names of the files
micMatrix = [0 0 1.7; 0.9 0 0.1; 1.83 0 0.5; 0 2.4 0.1; 1.83 2.40 1.8; 0 4.45 1.1; 0.9 4.45 0.1; 1.83 4.45 1.08];
nbrOfSpeakers = 8;
microphones = {'mic1_0320_20.wav';'mic2_0320_20.wav';'mic3_0320_20.wav';'mic4_0320_20.wav';'mic5_0320_20.wav';'mic6_0320_20.wav';'mic7_0320_20.wav';'mic8_0320_20.wav'};

%Reads the data and plots them
signalMatrix = [];
f=0;
for i = 1:nbrOfSpeakers
    [mic, f] = audioread(microphones{i});
    signalMatrix{i} = mic;
    hold on
    plot(mic);
end

j = 1600000;
%Generate the data after sync
figure;
for i = 1:nbrOfSpeakers
    signalMatrix{i} = signalMatrix{i}(j:end);
    plot(signalMatrix{i});
    hold on;
end

%%
%Choose data and generate wavfile

s = 250000:3600000;

for i = 1:nbrOfSpeakers
    signalMatrix{i} = signalMatrix{i}(s);
end

sz = length(signalMatrix{1});
counter = 1;

for i = 1:nbrOfSpeakers
    for j = 1:10*f:sz - 10*f
        filename = sprintf('people_%d.wav', counter);
        audiowrite(filename,signalMatrix{i}(j:j+10*f),48000);
        counter = counter + 1;
    end
end












