function outF = ourFunc4Combo(param, tdoa, micMatrix, combo)
x = param(1);
y = param(2);
z = param(3);


func1 = tdoa{1} - sqrt((x-micMatrix(combo(1),1)).^2 + (y-micMatrix(combo(1),2)).^2 + (z-micMatrix(combo(1),3)).^2) + sqrt((x-micMatrix(combo(2),1)).^2 + (y-micMatrix(combo(2),2)).^2 + (z-micMatrix(combo(2),3)).^2);
func2 = tdoa{2} - sqrt((x-micMatrix(combo(1),1)).^2 + (y-micMatrix(combo(1),2)).^2 + (z-micMatrix(combo(1),3)).^2) + sqrt((x-micMatrix(combo(3),1)).^2 + (y-micMatrix(combo(3),2)).^2 + (z-micMatrix(combo(3),3)).^2);
func3 = tdoa{3} - sqrt((x-micMatrix(combo(1),1)).^2 + (y-micMatrix(combo(1),2)).^2 + (z-micMatrix(combo(1),3)).^2) + sqrt((x-micMatrix(combo(4),1)).^2 + (y-micMatrix(combo(4),2)).^2 + (z-micMatrix(combo(4),3)).^2);

outF = [func1 func2 func3];

end