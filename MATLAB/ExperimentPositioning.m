close all;
clear all;

%Initialize camera position, number of speakers and the names of the files
cameraMatrix = [0 0 1.7; -0.1 2.7 1.7; 2.2 0.5 1.68; 2.1 2.7 1.85; 1.2 1.65 0.1];
nbrOfSpeakers = 5;
microphones = ['mic1.wav'; 'mic2.wav'; 'mic3.wav'; 'mic4.wav'; 'mic5.wav'];

%Reads the data and plots them
micMatrix = [];
f=0;
for i = 1:nbrOfSpeakers
    [mic, f] = audioread(microphones(i,:));
    mic = mic - mean(mic);
    micMatrix{i} = mic;
    hold on
    plot(mic);
end

%Syncs all the microphones using mic1 as master, then plot the result.
%Distance between the microphones are also shown as an indicator of how
%good the sync was.
j=200000;
figure;
plot(micMatrix{1});
for i = 2:nbrOfSpeakers
   s1 = 1:200000;
   s = j:j+200000;
   [mic, dist, ~] = ourSync2(micMatrix{1}, micMatrix{i}, s1, s);
   micMatrix{i} = mic;
   j = j+200000;
   hold on
   plot(micMatrix{i});
   dist{i} = dist;
end

%syncQuality1 = checkSync(cameraMatrix, dist12, dist13, dist14);
%syncQuality2 = checkSync2(mic2, mic3, s2, s3);
%syncQuality3 = checkSync2(mic3, mic4, s3, s4);

%Generate the data after sync
figure;
for i = 1:nbrOfSpeakers
    micMatrix{i} = micMatrix{i}(j:end);
    plot(micMatrix{i});
    hold on;
end

%%
s = 1:350000;
%Calculates the sound source position
[xS, yS, zS] = ExperimentLM(micMatrix, nbrOfSpeakers, cameraMatrix);

%Scatterplots them.
ExperimentscatterPlot(cameraMatrix, nbrOfSpeakers, xS, yS, zS)


