close all;
clear all;

[mic1, f] = audioread('cap168.wav');
[mic2, f] = audioread('cap99.wav');
[mic3, f] = audioread('cap38.wav');

size = length(mic1)

plot(mic1)
hold on
plot(mic2)
plot(mic3)
figure

mic1 = mic1 - mean(mic1);
mic2 = mic2 - mean(mic2);
mic3 = mic3 - mean(mic3);

[x1Start x1End] = findTone(mic1,mic2,mic3);
s2 = x1End:length(mic1);
[x2Start x2End] = findTone(mic1(s2),mic2(s2),mic3(s2));
s3 = (x1End + x2End):length(mic1);
[x3Start x3End] = findTone(mic1(s3),mic2(s3),mic3(s3));

s1 = x1Start:x1End;
s2 = x1End + x2Start:x1End + x2End;
s3 = x1End + x2End + x3Start:x1End + x2End + x3End;

plot(mic1)
hold on
plot(mic2)
plot(mic3)
plot(x1Start,0.05,'o');
plot(x1End,0.05,'o');
plot(x1End + x2Start,0.05,'o');
plot(x1End + x2End,0.05,'o');
plot(x1End + x2End + x3Start,0.05,'o');
plot(x1End + x2End + x3End,0.05,'o');

mic2 = ourSync(mic1, mic2, s1, s2);
mic3 = ourSync(mic1, mic3, s1, s3);

plot(mic1)
hold on
plot(mic2)
plot(mic3)


tdoa12 = ourGccphat(mic1(s3),mic2(s3));
deltaS12 = abs(tdoa12/f*343);
tdoa13 = ourGccphat(mic1(s2),mic3(s2));
deltaS13 = abs(tdoa13/f*343);
tdoa23 = ourGccphat(mic2(s1),mic3(s1));
deltaS23 = abs(tdoa23/f*343);


disp("delta12 = " + deltaS12);
disp("delta13 = " + deltaS13);
disp("delta23 = " + deltaS23);




