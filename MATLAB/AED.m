close all
clear all
[mic1, f] = audioread('000217_241_mono1.wav');
[mic2, f] = audioread('000217_241_mono2.wav');
% mic2 = [zeros(300,1); mic1];


plot(mic1)
figure
plot(mic2)
figure

mic1 = mic1(50000:120000);
mic2 = mic2(50000:120000);

x = [mic1' mic2'];
M = length(mic1);

g1 = zeros(M,1);
g2 = zeros(M,1);
g2(floor(M/2)) = sqrt(1)/2;
g1(floor(M/2)) = sqrt(1)/2;
u = [g2' -g1'];

mu = 0.6;

for i = 1:M
    e = u*x';
    u = (u-mu*e*x)/norm(u-mu*e*x);
end

g1 = u(M+1:2*M);
g2 = u(1:M);
[~, idxg1] = max(abs(g1));
[~, idxg2] = max(abs(g2));
D = idxg1 - idxg2;
plot(u)
tdoa = D/f*343;

tdoaGCC = ourGccphat(mic1,mic2)/f*343;


