close all;
clear all;

f = 48000;
reclength = f*16;

off1 = rand()*0.01;
off2 = rand()*0.01;
off3 = rand()*0.01;

noise1 = (rand(1,reclength)*2-1)*0.005 + off1;
noise2 = (rand(1,reclength)*2-1)*0.005 + off2;
noise3 = (rand(1,reclength)*2-1)*0.005 + off3;


sFreq = 4000;
sLength = 1*f;
xSignal = 1:sLength;
signal = sin(sFreq/sLength*2*pi*xSignal);


delay1 = floor((rand()*2-1)*f);
delay2 = floor((rand()*2-1)*f);
delay3 = floor((rand()*2-1)*f);

dist12 = 5;
dist13 = 5;
dist23 = 5;

amp = 0.07;

mic1 = zeros(1,reclength);
mic1(2*f + 1:2*f + sLength) = amp*signal;
mic1(6*f + floor(dist12/343*f) + 1:6*f + floor(dist12/343*f) + sLength) = amp*0.4*signal;
mic1(10*f+ floor(dist13/343*f) + 1:10*f + floor(dist13/343*f) + sLength) = amp*0.4*signal;
mic1 = mic1 + noise1;

mic2 = zeros(1,reclength);
mic2(2*f + floor(dist12/343*f) + 1:2*f + floor(dist12/343*f) + sLength) = amp*0.4*signal;
mic2(6*f + 1:6*f + sLength) = amp*signal;
mic2(10*f + floor(dist23/343*f) + 1:10*f + floor(dist23/343*f) + sLength) = amp*0.2*signal;
mic2 = mic2 + noise2;

mic3 = zeros(1,reclength);
mic3(2*f + floor(dist13/343*f) + 1:2*f + floor(dist13/343*f) + sLength) = amp*0.4*signal;
mic3(6*f + floor(dist23/343*f) + 1:6*f + floor(dist23/343*f) + sLength) = amp*0.2*signal;
mic3(10*f+ 1:10*f + sLength) = amp*signal;
mic3 = mic3 + noise3;


if delay1 > 0
    tmp = (rand(1,delay1)*2-1)*0.005 + off1;
    mic1 = [tmp mic1];
elseif delay1 < 0
    mic1 = mic1(-delay1:end);
    tmp = (rand(1,-delay1)*2-1)*0.005 + off1;
    mic1 = [mic1 tmp];
end


if delay2 > 0
    tmp = (rand(1,delay2)*2-1)*0.005 + off2;
    mic2 = [tmp mic2];
elseif delay2 < 0
    mic2 = mic2(-delay2:end);
    tmp = (rand(1,-delay2)*2-1)*0.005 + off2;
    mic2 = [mic2 tmp];
end



if delay3 > 0
    tmp = (rand(1,delay3)*2-1)*0.005 + off3;
    mic3 = [tmp mic3];
elseif delay3 < 0
    mic3 = mic3(-delay3:end);
    tmp = (rand(1,-delay3)*2-1)*0.005 + off3;
    mic3 = [mic3 tmp];
end

plot(mic1);
hold on
plot(mic2);
plot(mic3);
figure

mic1 = mic1';
mic2 = mic2';
mic3 = mic3';

mic1 = mic1 - mean(mic1);
mic2 = mic2 - mean(mic2);
mic3 = mic3 - mean(mic3);

s1 = 1:200000;
s2 = 200001:400000;
s3 = 400001:600000;

mic2 = ourSync2(mic1, mic2, s1, s2);
mic3 = ourSync2(mic1, mic3, s1, s3);

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



















