clear all
close all

[mic1, Fs1] = audioread('cap99.wav');
[mic2, Fs2] = audioread('cap168.wav');

mic1 = mic1 - mean(mic1);
mic2 = mic2 - mean(mic2);

y1 = mic1(1:200000);
y2 = mic2(1:200000);

gcctdoa1 = ourGccphat(y1,y2);
corre = xcorr(y1, y2);
[C I] = max(corre);
corrtdoa1 = ((length(corre)+1)/2 - I);


y1 = mic1(200000:400000);
y2 = mic2(200000:400000);
gcctdoa2 = ourGccphat(y1,y2);
corre = xcorr(y1, y2);
[C I] = max(corre);
corrtdoa2 = ((length(corre)+1)/2 - I);

plot(mic2)
hold on
plot(mic1)


gcctdoa = (gcctdoa1 - gcctdoa2)/2;
gcctdoa = gcctdoa/Fs1;
gccdeltaS = 343*gcctdoa;


corrtdoa = (corrtdoa2 - corrtdoa1)/2;
corrtdoa = corrtdoa/Fs1;
corrdeltaS = 343*corrtdoa


%%
close all;

gcctdoa = floor(gccdeltaS/343*Fs1);

x1 = (1:200000-gcctdoa);
x2 = (gcctdoa:200000);

y1 = mic1(x2);
y2 = mic2(x1);


plot(y2)
hold on
plot(y1)

deltaT = ourGccphat(y1,y2);
deltaT = abs(deltaT)

%%

close all

y1 = mic1(375000-deltaT:end);
y2 = mic2(375000:end-deltaT);

plot(y2)
hold on
plot(y1)

gcctdoa = ourGccphat(y1,y2);
gcctdoa = gcctdoa/Fs1;
gccdeltaS = 343*gcctdoa


