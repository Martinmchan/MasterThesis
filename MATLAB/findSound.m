function [xStart xEnd] = findSound(signal)

signal = abs(signal);

treshold = 15;

x1 = 1;
x2 = 1;

size = length(signal);
movSize = 2000;
avg = mean(signal(1:movSize));


for i = movSize:(size-movSize)
    if signal(i) > treshold*avg
        x1 = i;
        break;
    else
        avg = avg + signal(i)/movSize - signal(i-movSize+1)/movSize;
    end     
end

avg = mean(signal(size-movSize:size));

for i = (size-movSize):-1:movSize
    if signal(i) > treshold*avg
        x2 = i;
        break;
    else
        avg = avg - signal(i+movSize)/movSize + signal(i-1)/movSize;
    end     
end

extra = size/20;

xStart = x1 - extra;
xEnd = x2 + extra;

end
