function outF = myFunc(param, tdoa12, tdoa13, tdoa14, xyz)
x = param(1);
y = param(2);
z = param(3);

func1 = tdoa12 - sqrt((x-xyz(1,1)).^2 + (y-xyz(1,2)).^2 + (z-xyz(1,3)).^2) + sqrt((x-xyz(2,1)).^2 + (y-xyz(2,2)).^2 + (z-xyz(2,3)).^2);
func2 = tdoa13 - sqrt((x-xyz(1,1)).^2 + (y-xyz(1,2)).^2 + (z-xyz(1,3)).^2) + sqrt((x-xyz(3,1)).^2 + (y-xyz(3,2)).^2 + (z-xyz(3,3)).^2);
func3 = tdoa14 - sqrt((x-xyz(1,1)).^2 + (y-xyz(1,2)).^2 + (z-xyz(1,3)).^2) + sqrt((x-xyz(4,1)).^2 + (y-xyz(4,2)).^2 + (z-xyz(4,3)).^2);

outF = [func1; func2; func3];

end

