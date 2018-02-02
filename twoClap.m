clear all;
close all;
[y116, f] = audioread('cap116.wav');
[y38, f] = audioread('cap38.wav');

plot(y116);
figure
plot(y38);
figure
plot(y116,'r');
hold on
plot(y38);
figure

x116 = find(y116 > 0.03);
x38 = find(y38 > 0.03);

x116c1 = 42720;
x116c2 = 103420;
delta116 = x116c2-x116c1;
x38c1 = 53860;
x38c2 = 114210;
delta38 = x38c2-x38c1;

T = (delta116-delta38)/2/48000;
deltaS = T*343


[yt116, f] = audioread('tascam116.wav');
[yt38, f] = audioread('tascam38.wav');

hold off
plot(yt116);
figure
plot(yt38);
figure
plot(yt116,'r');
hold on
plot(yt38);

xt116 = find(yt116 > 0.03);
xt38 = find(yt38 > 0.03);

xt116c1 = 191395;
xt116c2 = 252026;
deltat116 = xt116c2-xt116c1;
xt38c1 = 191531;
xt38c2 = 251906;
deltat38 = xt38c2-xt38c1;

Tt = (deltat116-deltat38)/2/48000;
deltaSt = Tt*343

%%
close all;
clear all;
[y116, f] = audioread('cap116.wav');
[y38, f] = audioread('cap38.wav');



plot(y116);
figure
plot(y38);
figure
plot(y116,'r');
hold on
plot(y38);
figure

xA = 40000:70000;
xB = 100000:125000;

suby116A = y116(xA);
suby38A = y38(xA);

suby116B = y116(xB);
suby38B = y38(xB);






correA = xcorr(suby116A, suby38A);
[C IA] = max(correA);
tdoaA= ((length(correA)+1)/2 - IA)/f;


correB = xcorr(suby116B, suby38B);
[C IB] = max(correB);
tdoaB= ((length(correB)+1)/2 - IB)/f;

T = (tdoaA - tdoaB)/2;
deltaS = 343*T

















