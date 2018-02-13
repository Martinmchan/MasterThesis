function outF = myFunc(param)
x = param(1);
y = param(2);
z = param(3);

mic1 = [0,2,2];
mic2 = [2,0,2];
mic3 = [2,2,2];
mic4 = [0,0,2];
%mic5 = [1,2,2];


dist12 = norm(mic1) - norm(mic2);
dist13 = norm(mic1) - norm(mic3);
dist14 = norm(mic1) - norm(mic4);
%dist15 = norm(mic1) - norm(mic5);

func1 = dist12 - sqrt((x-mic1(1)).^2 + (y-mic1(2)).^2 + (z-mic1(3)).^2) + sqrt((x-mic2(1)).^2 + (y-mic2(2)).^2 + (z-mic2(3)).^2);
func2 = dist13 - sqrt((x-mic1(1)).^2 + (y-mic1(2)).^2 + (z-mic1(3)).^2) + sqrt((x-mic3(1)).^2 + (y-mic3(2)).^2 + (z-mic3(3)).^2);
func3 = dist14 - sqrt((x-mic1(1)).^2 + (y-mic1(2)).^2 + (z-mic1(3)).^2) + sqrt((x-mic4(1)).^2 + (y-mic4(2)).^2 + (z-mic4(3)).^2);
%func4 = dist15 - sqrt((x-mic1(1)).^2 + (y-mic1(2)).^2 + (z-mic1(3)).^2) + sqrt((x-mic5(1)).^2 + (y-mic5(2)).^2 + (z-mic5(3)).^2);


outF = [func1; func2; func3];

end

