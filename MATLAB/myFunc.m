function outF = myFunc(param)
x = param(1);
y = param(2);
z = param(3);

mic1 = [61,32,0];
mic2 = [1,2,0];
mic3 = [-2,-20,0];

dist12 = norm(mic1) - norm(mic2);
dist13 = norm(mic1) - norm(mic3);
dist23 = norm(mic2) - norm(mic3);

func1 = abs(sqrt((x-mic1(1)).^2 + (y-mic1(2)).^2 + (z-mic1(3)).^2) - sqrt((x-mic2(1)).^2 + (y-mic2(2)).^2 + (z-mic2(3)).^2))-abs(dist12);
func2 = abs(sqrt((x-mic1(1)).^2 + (y-mic1(2)).^2 + (z-mic1(3)).^2) - sqrt((x-mic3(1)).^2 + (y-mic3(2)).^2 + (z-mic3(3)).^2))-abs(dist13);
func3 = abs(sqrt((x-mic2(1)).^2 + (y-mic2(2)).^2 + (z-mic2(3)).^2) - sqrt((x-mic3(1)).^2 + (y-mic3(2)).^2 + (z-mic3(3)).^2))-abs(dist23);


outF = [func1; func2; func3];

end

