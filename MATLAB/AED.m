close all
[mic1, f] = audioread('000217_241_mono1.wav');
[mic2, f] = audioread('000217_241_mono2.wav');

plot(mic1)
figure
plot(mic2)

x = [mic1' mic2'];
M = length(mic1);

hb = zeros(M,1);
hp = zeros(M,1);
hb(floor(M/2)) = 1;
u = [hb' -hp'];
mu = 0.003;
for i = 1:2*M
    e = u*x';
    u(i+1) = (u(i)-mu*e*x(i));    
end

[~, idx2] = min(u(M+1:2*M));
[~, idx1] = min(u(1:M));
D = (M + idx2) - idx1;
plot(u)
tdoa = D/f*343;

tdoaGCC = ourGccphat(mic1,mic2)/f*343;


