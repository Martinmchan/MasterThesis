close all;
clear all;

[yPiff, f] = audioread('testTone.wav');
[yPuff, f] = audioread('recordTestTone.wav');


plot(yPiff);
figure;
plot(yPuff);
% 
% xPiff = find(yPiff>0.01,1); 
% xPuff = find(yPuff>0.01,1); 
% 
% cPiff_a = xPiff/f*1000000;
% cPuff_b = xPuff/f*1000000;
% 
% t_1a = -104068448;
% t_2a = -98680942;
% 
% t_1b = -102703769;
% t_2b = -99707112;
% 
% T = (cPiff_a + cPuff_b + t_1a + t_2b - t_1b - t_2a)/2;
% deltaS = T*343/1000000