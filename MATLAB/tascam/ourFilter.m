function y = ourFilter(y,f1,f2)
    Y = fft(y);
    sz = length(Y);
    Y = Y(1:floor(sz/2));
    Y(f1:f2) = 0;
    y = real(ifft(Y));
end