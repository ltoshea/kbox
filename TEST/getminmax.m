function [imax,imin,zmax,zmin] = getminmax(yfitted)
[zmax,imax,zmin,imin] = extrema(yfitted);
hold on;
plot((imax),zmax,'r*',(imin),zmin,'g*');
%plot(xData,yfitted);