clear all
close all
[mic1, Fs1] = audioread('sim99.wav');
[mic2, Fs2] = audioread('sim168.wav');

mic1 = mic1 - mean(mic1);
mic2 = mic2 - mean(mic2);

y1 = mic1(90000:200000);
y2 = mic2(90000:200000);

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
gccdeltaS = 343*gcctdoa


corrtdoa = (corrtdoa2 - corrtdoa1)/2;
corrtdoa = corrtdoa/Fs1;
corrdeltaS = 343*corrtdoa
