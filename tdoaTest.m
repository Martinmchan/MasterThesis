clear all
close all

[y1, Fs1] = audioread('000103_240_mono1.wav');
[y3, Fs3] = audioread('000103_240_mono2.wav');

[sz, ~] = size(y1);
treshold = max(y3);
tresholdValue = find(y3 >= treshold);


start = tresholdValue(1) - floor(sz/200);
finish = tresholdValue(1) + floor(sz/50);

suby1 = y1(start:finish);
suby3 = y3(start:finish);

% plot(suby1)
% hold on
% plot(suby3)

L = finish-start;

Ncorr = 2*L-1; 
NFFT = 2^nextpow2(Ncorr);
R12 = bsxfun(@times,fft(suby3,NFFT),conj(fft(suby1,NFFT)));
r12_temp = fftshift(ifft(exp(1i*angle(R12))),1);
r12 = r12_temp(NFFT/2+1-(L-1)/2:NFFT/2+1+(L-1)/2,:);

lags = (-(Ncorr-1)/2:(Ncorr-1)/2).';
lags = lags/Fs1;
[~,idx] = max(abs(r12));
tau = L/(2*Fs1)+lags(idx)
deltaS = 343*tau


