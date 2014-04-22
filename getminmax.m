function [imax,imin,zmax,zmin] = getminmax(Z2)

[zmax,imax,zmin,imin] = extrema(Z2(1,:));
if length(imax) > 1
    imax(:,end) = []; %Manually making sure we have same number of min and max points.
    zmax(:,end) = [];
end

%hold on;
% Plots min/max on smoothed curve
% plot((imax),zmax,'r*',(imin),zmin,'g*');
% plot(xData,yfitted);