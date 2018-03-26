function para = paraGCCPhat(mic1, mic2, mic3)


total = [mic1; mic2; mic3];
maxAmp = max(total)
maxAmp = 0.21;
x = 0:0.001:maxAmp;
count = zeros(1,length(x));

for i = 1:length(total)
    for j = length(x):-1:1
        if abs(total(i)) > x(j)
            count(j) = count(j) + 1;
            break;
        end
    end
end

plot(x,count)

para = count;

end
