function [ imax ] = pythagoras3( imax,NORM )
%cleandata Gets rid of errenous data
%   Uses Pythagoras to find out distance between minima and next maxima. 
%   if the distance is too low we know it's a straight line so can cut it
%   out.


remove=0;
if (NORM == 0)
    for i=1:length(imax)-1
        if norm(imax(:,i)-imax(:,i+1)) < 10
            remove = vertcat(remove,i);
        end
    end
end

if (NORM == 1)
    for i=1:length(imax)-1
        if norm(imax(:,i)-imax(:,i+1)) < 10
            remove = vertcat(remove,i);
        end
    end
end
remove(1,:) = [];
imax(:,remove) = [];

end

