function tdoa = ourGCCphat(mic1,mic2)
    N = length(mic1);
    Ncorr = 2*N-1;
    NFFT = 2^nextpow2(Ncorr);
    func = @(x) 1./(abs(x)+(abs(x)<5e-3));
    R12 = bsxfun(@times,fft(mic1,NFFT),conj(fft(mic2,NFFT)));
    r12_temp = fftshift(ifft(R12.*func(R12)),1);
    r12 = r12_temp(floor(NFFT/2)+1-floor((N-1)/2):floor(NFFT/2)+1+floor((N-1)/2));
    lags = (-(Ncorr-1)/2:(Ncorr-1)/2).';
    [~,idx] = max(abs(r12));
    tdoa = floor((N/2+lags(idx)));
end