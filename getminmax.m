function [zmax,imax,zmin,imin] = getminmax(Z2,pno)
%pno = punch number
%    ZMAX - maxima points in descending order
%    IMAX - indexes of the XMAX
%    ZMIN - minima points in descending order
%    IMIN - indexes of the XMIN

[zmax,imax,zmin,imin] = extrema(Z2(1,:));

if length(imax) > 1
    %imax(:,end) = []; %Manually making sure we have same number of min and max points.
    %zmax(:,end) = [];
end

%Special min/max for cross
% if pno==2
%     distance = norm(
    



figure
hold on;
% Plots min/max on smoothed curve
 plot((imax),zmax,'r*',(imin),zmin,'g*');
 plot(Z2(1,:));