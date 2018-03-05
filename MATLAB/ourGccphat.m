function tdoa = ourGccphat(mic1,mic2)
%GCC-Phat
N = length(mic1);
Ncorr = 2*N-1;
NFFT = Ncorr;
%NFFT = 2^nextpow2(Ncorr);
func = @(x) 1./(abs(x)+(abs(x)<20e-3));
R12 = bsxfun(@times,fft(mic1,NFFT),conj(fft(mic2,NFFT)));
r12_temp = fftshift(ifft(R12.*func(R12)),1);
r12 = r12_temp(floor(NFFT/2)+1-floor((N-1)/2):floor(NFFT/2)+1+floor((N-1)/2));
figure
plot(343/48000*[-floor(length(r12)/2):floor(length(r12)/2)],abs(r12));


%Finding the TDOA and distance between microphones
lags = (-(Ncorr-1)/2:(Ncorr-1)/2).';
[~,idx] = max(abs(r12));
tdoa1 = floor((N/2+lags(idx)));
r12(idx-5:idx+5) = 0;

[~,idx] = max(abs(r12));
tdoa2 = floor((N/2+lags(idx)));
r12(idx-5:idx+5) = 0;

[~,idx] = max(abs(r12));
tdoa3 = floor((N/2+lags(idx)));
r12(idx-5:idx+5) = 0;

[~,idx] = max(abs(r12));
tdoa4 = floor((N/2+lags(idx)));
r12(idx-5:idx+5) = 0;

[~,idx] = max(abs(r12));
tdoa5 = floor((N/2+lags(idx)));

tdoa = [tdoa1, tdoa2, tdoa3, tdoa4, tdoa5];
end
