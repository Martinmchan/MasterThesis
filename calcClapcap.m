clear all;
close all;
[yc1e1, f] = audioread('cap1Exp1.wav');
[yc2e1, f] = audioread('cap2Exp1.wav');
[yc1e2, f] = audioread('cap1Exp2.wav');
[yc2e2, f] = audioread('cap2Exp2.wav');

plot(yc1e1);
figure
plot(yc2e1);
figure
plot(yc1e2);
figure
plot(yc2e2);

tC1E1 = 1697488464;
tC2E1 = 1697040080;
tC1E2 = 1789542393;
tC2E2 = 1789371896;

xC1E1 = find(yc1e1>0.1,1); 
xC2E1 = find(yc2e1>0.1,1); 
xC1E2 = find(yc1e2>0.1,1);
xC2E2 = find(yc2e2>0.1,1);

PC1E1 = xC1E1/f*1000000;
PC2E1 = xC2E1/f*1000000;
PC1E2 = xC1E2/f*1000000;
PC2E2 = xC2E2/f*1000000;

T = (tC2E1 + PC2E1 + tC1E2 + PC1E2 - tC1E1 - PC1E1 - tC2E2 - PC2E2)/2;
deltaS = 343*T/1000000