function [ imax ] = pythagoras3( imax )
%cleandata Gets rid of errenous data
%   Uses Pythagoras to find out distance between minima and next maxima. 
%   if the distance is too low we know it's a straight line so can cut it
%   out.
%distance = 0;
remove=0;
for i=1:length(imax)-1
    if norm(imax(:,i)-imax(:,i+1)) < 20
        remove = vertcat(remove,i);
        %testimax(:,i+1) = [];
    end
    %distance = vertcat(distance,norm(imax(i)-imax(i+1)));
end
remove(1,:) = [];
imax(:,remove) = [];

%pause
%dist_imax=horzcat(imax',distance);

%m3(:,[1:2]) = [];
