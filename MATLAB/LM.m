clear all
close all
%Read the files
[y1, f] = audioread('000129_244_mono1.wav');
[y2, f] = audioread('000129_244_mono2.wav');
[y3, f] = audioread('000129_244_mono3.wav');
[y4, f] = audioread('000129_244_mono4.wav');

plot(y1)
hold on

%Locate the sound in time
[xStart xEnd] = findSound(y1);
y1 = y1(xStart:xEnd);
y2 = y2(xStart:xEnd);
y3 = y3(xStart:xEnd);
y4 = y4(xStart:xEnd);


plot(xStart,0,'go');
plot(xEnd,0,'ro');


%Compute tdoa
tdoa12 = ourGccphat(y1, y2)/f*343;
tdoa13 = ourGccphat(y1, y3)/f*343;
tdoa14 = ourGccphat(y1, y4)/f*343;

%The microphones positions
xyz = [0 0 0; 0 2 0; 1 2 0; 1 0 0];

%Initial guess
x0 = [1,1,1]';

%Boundaries on the room
lb = [0,0,0];
ub = [1,2,2];

%Calculate the position of the sound source using Levenberg-Marquardt
options.Algorithm = 'levenberg-marquardt';
xP = lsqnonlin(@myFunc,x0, lb,ub, [], tdoa12, tdoa13, tdoa14, xyz)



param1 = xP;
a1 = myFunc(param1, tdoa12, tdoa13, tdoa14, xyz);
% param2 = [0,0,0];
% a2 = myFunc(param2);
