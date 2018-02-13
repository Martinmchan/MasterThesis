clear all
x0 = [90,2,3]';

lb = [0,0,0];
ub = [2,2,2];

options.Algorithm = 'levenberg-marquardt';


xP = lsqnonlin(@myFunc,x0, lb,ub)

param1 = xP;
a1 = myFunc(param1);
param2 = [0,0,0];
a2 = myFunc(param2);
