clear all;
close all;
[X,Y,Z] = meshgrid(-10:0.5:10,-10:0.5:10,-10:0.5:10);
a=1;
b=1;
c=1;
V = abs(sqrt((X).^2+(Y).^2) - sqrt((X - 2).^2+(Y).^2));
p1=patch(isosurface(X,Y,Z,V,2)); 

set(p1,'FaceColor','green','EdgeColor','none');

daspect([1 1 1])
view(3);
camlight