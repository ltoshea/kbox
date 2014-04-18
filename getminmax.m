function [imax,imin,zmax,zmin] = getminmax(Z2)

[zmax,imax,zmin,imin] = extrema(Z2(1,:));
hold on;
plot((imax),zmax,'r*',(imin),zmin,'g*');
%plot(xData,yfitted);