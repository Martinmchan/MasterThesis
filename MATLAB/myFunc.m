function outF = myFunc(param)
x = param(1);
y = param(2);
z = param(3);

mic1 = [0,2,0];
mic2 = [2,2,0];
mic3 = [2,0,0];
mic4 = [5,9,1];
mic5 = [-5, -6, -3];


dist12 = norm(mic1) - norm(mic2);
dist13 = norm(mic1) - norm(mic3);
dist23 = norm(mic2) - norm(mic3);
% dist14 = norm(mic1) - norm(mic4);
% dist24 = norm(mic2) - norm(mic4);
% dist34 = norm(mic3) - norm(mic4);
% dist15 = norm(mic1) - norm(mic5);
% dist25 = norm(mic2) - norm(mic5);
% dist35 = norm(mic3) - norm(mic5);
% dist45 = norm(mic4) - norm(mic5);
% 

func1 = abs(dist12) - abs(sqrt((x-mic1(1)).^2 + (y-mic1(2)).^2 + (z-mic1(3)).^2) - sqrt((x-mic2(1)).^2 + (y-mic2(2)).^2 + (z-mic2(3)).^2));
func2 = abs(dist13) - abs(sqrt((x-mic1(1)).^2 + (y-mic1(2)).^2 + (z-mic1(3)).^2) - sqrt((x-mic3(1)).^2 + (y-mic3(2)).^2 + (z-mic3(3)).^2));
%func3 = abs(dist14) - abs(sqrt((x-mic1(1)).^2 + (y-mic1(2)).^2 + (z-mic1(3)).^2) - sqrt((x-mic4(1)).^2 + (y-mic4(2)).^2 + (z-mic4(3)).^2));
 func3 = abs(dist23) - abs(sqrt((x-mic2(1)).^2 + (y-mic2(2)).^2 + (z-mic2(3)).^2) - sqrt((x-mic3(1)).^2 + (y-mic3(2)).^2 + (z-mic3(3)).^2));
% func5 = abs(dist24) - abs(sqrt((x-mic2(1)).^2 + (y-mic2(2)).^2 + (z-mic2(3)).^2) - sqrt((x-mic4(1)).^2 + (y-mic4(2)).^2 + (z-mic4(3)).^2));
% func6 = abs(dist34) - abs(sqrt((x-mic3(1)).^2 + (y-mic3(2)).^2 + (z-mic3(3)).^2) - sqrt((x-mic4(1)).^2 + (y-mic4(2)).^2 + (z-mic4(3)).^2));
% func7 = abs(dist15) - abs(sqrt((x-mic1(1)).^2 + (y-mic1(2)).^2 + (z-mic1(3)).^2) - sqrt((x-mic5(1)).^2 + (y-mic5(2)).^2 + (z-mic5(3)).^2));
% func8 = abs(dist25) - abs(sqrt((x-mic2(1)).^2 + (y-mic2(2)).^2 + (z-mic2(3)).^2) - sqrt((x-mic5(1)).^2 + (y-mic5(2)).^2 + (z-mic5(3)).^2));
% func9 = abs(dist35) - abs(sqrt((x-mic3(1)).^2 + (y-mic3(2)).^2 + (z-mic3(3)).^2) - sqrt((x-mic5(1)).^2 + (y-mic5(2)).^2 + (z-mic5(3)).^2));
% func10 = abs(dist45) - abs(sqrt((x-mic4(1)).^2 + (y-mic4(2)).^2 + (z-mic4(3)).^2) - sqrt((x-mic5(1)).^2 + (y-mic5(2)).^2 + (z-mic5(3)).^2));


outF = [func1; func2; func3];

end

