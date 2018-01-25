function distance = calcTDOA(mic1,mic2)

%Read the files and find the relevant data
[y1, Fs] = audioread(mic1);
[y2, Fs] = audioread(mic2);
[sz, ~] = size(y1);
treshold = max(y2);
tresholdValue = find(y2 >= treshold);
start = tresholdValue(1) - floor(sz/200);
finish = tresholdValue(1) + floor(sz/50);
suby1 = y1(start:finish);
suby2 = y2(start:finish);

%GCC-Phat
N = finish - start;
Ncorr = 2*N-1; 
NFFT = 2^nextpow2(Ncorr);
R12 = bsxfun(@times,fft(suby1,NFFT),conj(fft(suby2,NFFT)));
r12_temp = fftshift(ifft(exp(i*angle(R12))),1);
r12 = r12_temp(NFFT/2+1-(N-1)/2:NFFT/2+1+(N-1)/2,:);


%Finding the TDOA and distance between microphones
lags = (-(Ncorr-1)/2:(Ncorr-1)/2).';
[~,idx] = max(abs(r12));
tau = (N/2+lags(idx))/Fs;
distance = 343*tau;
end
