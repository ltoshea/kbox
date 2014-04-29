function [ dist_imax ] = pythagoras( imax )
%cleandata Gets rid of errenous data
%   Uses Pythagoras to find out distance between minima and next maxima. 
%   if the distance is too low we know it's a straight line so can cut it
%   out.
distance = 0;
for i=1:length(imax)-1 %need to find a smart way to loop this
    distance = norm(imax(i)-imax(i+1));
    if distance < 20
        imax(:,i+1) = []; %Remove next point
    end
    %distance = vertcat(distance,norm(imax(i)-imax(i+1)));
end
dist_imax=horzcat(imax',distance);

%m3(:,[1:2]) = [];