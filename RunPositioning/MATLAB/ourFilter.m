function y = ourFilter(y,f1,f2)
    Y = fft(y);
    sz = length(Y);
    Y(f1:f2) = 0;
    Y(sz-f2:sz-f1+1) = 0;
    y = real(ifft(Y));
end