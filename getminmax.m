function [zmax,imax,zmin,imin] = getminmax(Z2,pno)
%pno = punch number
%    ZMAX - maxima points in descending order
%    IMAX - indexes of the XMAX
%    ZMIN - minima points in descending order
%    IMIN - indexes of the XMIN

[zmax,imax,zmin,imin] = extrema(Z2(1,:));


%Right handed punches seem to have a different profile (higher amplitude) than left 
if (pno == 2) | (pno == 4) 
    imax(zmax < 0.6) = [];
end

if pno==3
    sortp = [imax;zmax];
    [d1,d2] = sort(sortp(1,:));
    sortp2 = sortp(:,d2); %imax,zmax are now sorted, Need to fix pythag now.
    sortp2 = sortp2(:,(sortp2(2,:) > 0.2)) % Get rid of all points < 0.2
    tvar=pythagoras3(sortp2);
    imax = tvar(1,:);
    zmax = tvar(2,:);
    %plot(imax,zmax);
end
%pause

if (pno==6)
    sortp = [imax;zmax];
    [d1,d2] = sort(sortp(1,:));
    sortp2 = sortp(:,d2); %imax,zmax are now sorted, Need to fix pythag now.
    sortp2 = sortp2(:,(sortp2(2,:) > 0.3)) % Get rid of all points < 0.2
    tvar=pythagoras3(sortp2);
    imax = tvar(1,:);
    zmax = tvar(2,:);
    
end
end


%imax = sort(imax);
%imax = pythagoras(imax);
%if length(imax) > 1
    %imax(:,end) = []; %Manually making sure we have same number of min and max points.
    %zmax(:,end) = [];
%end

     



