function tdoa = ourGccphat(mic1,mic2)


%GCC-Phat
N = length(mic1);
Ncorr = 2*N-1; 
NFFT = 2^nextpow2(Ncorr);
func = @(x) 1./(abs(x)+(abs(x)<7e-3));
R12 = bsxfun(@times,fft(mic1,NFFT),conj(fft(mic2,NFFT)));
r12_temp = fftshift(ifft(R12.*func(R12)),1);
r12 = r12_temp(NFFT/2+1-(N-1)/2:NFFT/2+1+(N-1)/2);


%Finding the TDOA and distance between microphones
lags = (-(Ncorr-1)/2:(Ncorr-1)/2).';
[~,idx] = max(abs(r12));
tdoa = floor((N/2+lags(idx)));

end