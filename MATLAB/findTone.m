function [xStart xEnd] = findTone(mic1, mic2, mic3)
mic1 = abs(mic1);
mic2 = abs(mic2);
mic3 = abs(mic3);

treshold = 10;

x1 = 1;
x2 = 1;
x3 = 1;

size = 1000;
avg = mean(mic1(1:size));
for i = size:(length(mic1)-size)
    if mic1(i) > treshold*avg
        x1 = i;
        break;
    else
        avg = avg + mic1(i)/size - mic1(i-size+1)/size;
    end     
end

avg = mean(mic2(1:size));
for i = size:(length(mic2)-size)
    if mic2(i) > treshold*avg
        x2 = i;
        break;
    else
        avg = avg + mic3(i)/size - mic3(i-size+1)/size;
    end     
end

avg = mean(mic3(1:size));
for i = size:(length(mic3)-size)
    if mic3(i) > treshold*avg
        x3 = i;
        break;
    else
        avg = avg + mic3(i)/size - mic3(i-size+1)/size;
    end     
end

x = [x1 x2 x3]

xStart = min(x)-20000;
xEnd = max(x)+48000+20000;

end
