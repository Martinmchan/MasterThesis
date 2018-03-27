function tdoa = ourAED(mic1,mic2)
    x = [mic1' mic2'];
    M = length(mic1);
    g1 = zeros(M,1);
    g2 = zeros(M,1);
    g2(floor(M/2)) = sqrt(1)/2;
    g1(floor(M/2)) = sqrt(1)/2;
    u = [g2' -g1'];

    mu = 0.6;

    for i = 1:M
        e = u*x';
        u = (u-mu*e*x)/norm(u-mu*e*x);
    end

    g1 = u(M+1:2*M);
    g2 = u(1:M);
    [~, idxg1] = max(abs(g1));
    [~, idxg2] = max(abs(g2));
    tdoa = idxg2 - idxg1;
end