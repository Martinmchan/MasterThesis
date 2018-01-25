clear all;
close all;
[X,Y,Z] = meshgrid(-10:0.5:10,-10:0.5:10,-10:0.5:10);
a=1;
b=1;
c=1;
V = X.^2/a^2 + Y.^2/b^2 - Z.^2/c^2;
p1=patch(isosurface(X,Y,Z,V,1)); 
hold on
p2=patch(isosurface(X,Y,Z,V,5));
set(p1,'FaceColor','green','EdgeColor','none');
set(p2,'FaceColor','red','EdgeColor','none');
daspect([1 1 1])
view(3);
camlight