function outF = myFunc(param, tdoa12, tdoa13, tdoa14, xyz)
x = param(1);
y = param(2);
z = param(3);

% mic1 = [0,2,2];
% mic2 = [2,0,2];
% mic3 = [2,2,2];
% mic4 = [0,0,2];
% %mic5 = [1,2,2];
% 
% 
% dist12 = norm(mic1) - norm(mic2);
% dist13 = norm(mic1) - norm(mic3);
% dist14 = norm(mic1) - norm(mic4);
% %dist15 = norm(mic1) - norm(mic5);

func1 = tdoa12 - sqrt((x-xyz(1,1)).^2 + (y-xyz(1,2)).^2 + (z-xyz(1,3)).^2) + sqrt((x-xyz(2,1)).^2 + (y-xyz(2,2)).^2 + (z-xyz(2,3)).^2);
func2 = tdoa13 - sqrt((x-xyz(1,1)).^2 + (y-xyz(1,2)).^2 + (z-xyz(1,3)).^2) + sqrt((x-xyz(3,1)).^2 + (y-xyz(3,2)).^2 + (z-xyz(3,3)).^2);
func3 = tdoa14 - sqrt((x-xyz(1,1)).^2 + (y-xyz(1,2)).^2 + (z-xyz(1,3)).^2) + sqrt((x-xyz(4,1)).^2 + (y-xyz(4,2)).^2 + (z-xyz(4,3)).^2);
%func4 = dist15 - sqrt((x-mic1(1)).^2 + (y-mic1(2)).^2 + (z-mic1(3)).^2) + sqrt((x-mic5(1)).^2 + (y-mic5(2)).^2 + (z-mic5(3)).^2);

outF = [func1; func2; func3];

end

