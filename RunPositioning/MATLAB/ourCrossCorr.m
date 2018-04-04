function tdoa = ourCrossCorr(mic1,mic2)
    [acor,lag] = xcorr(mic1,mic2);
    [~,I] = max(abs(acor));
    tdoa = lag(I);
end