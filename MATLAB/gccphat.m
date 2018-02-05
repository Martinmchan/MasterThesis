mic1 = 'tascam38.wav';
mic2 = 'tascam116.wav';

%Read the files and find the relevant data
[y1, Fs] = audioread(mic1);
[y2, Fs] = audioread(mic2);
[sz, ~] = size(y1);


%GCC-Phat
N = length(y1);
Ncorr = 2*N-1; 
NFFT = 2^nextpow2(Ncorr);
func = @(x) 1./(abs(x)+(abs(x)<5e-2));
R12 = bsxfun(@times,fft(y1,NFFT),conj(fft(y2,NFFT)));
r12_temp = fftshift(ifft(R12.*func(R12)),1);
r12 = r12_temp(NFFT/2+1-(N-1)/2:NFFT/2+1+(N-1)/2);


%Finding the TDOA and distance between microphones
lags = (-(Ncorr-1)/2:(Ncorr-1)/2).';
[~,idx] = max(abs(r12));
tau = (N/2+lags(idx))/Fs;
distance = 343*tau
