clear all
x0 = [0.5,0.5,0.5]';

options.Algorithm = 'levenberg-marquardt';
options.ScaleProblem = 'jacobian';
xP = lsqnonlin(@myFunc,x0, [], [], options)

param1 = xP;
a1 = myFunc(param1);
param2 = [0,0,0];
a2 = myFunc(param2);
