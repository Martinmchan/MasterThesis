clear all
close all
%Read the files
[y1, f] = audioread('000129_242_mono1New.wav');
[y2, f] = audioread('000129_242_mono2New.wav');
[y3, f] = audioread('000129_242_mono3New.wav');
[y4, f] = audioread('000129_242_mono4New.wav');

plot(y2)
hold on


%Locate the sound in time
[xStart xEnd] = findSound(y1);
y1 = y1(xStart:xEnd);
y2 = y2(xStart:xEnd);
y3 = y3(xStart:xEnd);
y4 = y4(xStart:xEnd);


plot(xStart,0.1,'go');
plot(xEnd,0.1,'ro');


%Compute tdoa
[tdoa12a, tdoa12b, tdoa12c] = ourGccphat(y1, y2);
[tdoa13a, tdoa13b, tdoa13c] = ourGccphat(y1, y3);
[tdoa14a, tdoa14b, tdoa14c] = ourGccphat(y1, y4);


tdoa12a = tdoa12a/f*343;tdoa12b = tdoa12b/f*343;tdoa12c = tdoa12c/f*343;
tdoa13a = tdoa13a/f*343;tdoa13b = tdoa13b/f*343;tdoa13c = tdoa13c/f*343;
tdoa14a = tdoa14a/f*343;tdoa14b = tdoa14b/f*343;tdoa14c = tdoa14c/f*343;

%The microphones positions
xyz = [0 0 0; 0 1.35 0; 2.1 1.35 0; 2.1 0 0];

%Initial guess
x0 = [1.05,0.7,1]';

%Boundaries on the room
lb = [-0.1,-0.1,-0.1];
ub = [3,2,2.1];

%Calculate the position of the sound source using Levenberg-Marquardt
options.Algorithm = 'levenberg-marquardt';
xP = lsqnonlin(@myFunc,x0, lb,ub, [], tdoa12a, tdoa13a, tdoa14a, xyz)



param1 = xP;
a1 = myFunc(param1, tdoa12a, tdoa13a, tdoa14a, xyz);
% param2 = [0,0,0];
% a2 = myFunc(param2);
