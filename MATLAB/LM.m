clear all
x0 = [1.6,0.5,0]';

lb = [0,0,0];
ub = [2,2,0];

xP = lsqnonlin(@myFunc,x0, lb, ub)

param1 = xP;
a1 = myFunc(param1)
param2 = [0,0,0];
a2 = myFunc(param2);
