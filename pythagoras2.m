function [ imax ] = pythagoras2( imax )
%cleandata Gets rid of errenous data
%   Uses Pythagoras to find out distance between minima and next maxima. 
%   if the distance is too low we know it's a straight line so can cut it
%   out.
%distance = 0;
for i=1:length(imax)-10 %Need to figure out a better loop
    if norm(imax(i)-imax(i+1)) < 20
        imax(:,i+1) = [];
    end
    %distance = vertcat(distance,norm(imax(i)-imax(i+1)));
end
%dist_imax=horzcat(imax',distance);

%m3(:,[1:2]) = [];