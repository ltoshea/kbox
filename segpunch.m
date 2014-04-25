function [maxima] = segpunch(maxima,pno)

%going to do fancy things in here to ensure maxima are correct
if (pno==1)
    return
end

if (pno==2)
    newmax = [0,0];
    for i=1:length(maxima)
        if maxima(i,2) > 0.6
            newmax = vertcat(newmax,maxima(i,:));
        end
    end
    newmax(1,:) = [];    
end
maxima = newmax;
end




%Use pythagoras to see how close maxima is to next maxima
% distance = 0;
% for i=1:length(maxima)-1
%     temp = norm(maxima(i,:)-maxima(i+1,:)); 
%     distance = vertcat(distance,temp); ;
% end
% distance(1,:) = [];

%going to be hacky & removal all maxima < 0.6



% if (pno==2)
%     for i=1:length(maxima)
%         if maxima(i,2) < 0.6
%             maxima(i,2) = 0;
%         end
%     end
%     
%     %resize minus zeros
%     for i=1:length(maxima)
%         if maxima(i,2) == 0
%             maxima(i,:) = [];
%         end
%     end
%     %second for loop to get rid of all zeros
%     for i=1:length(maxima)
%         if maxima(i,2) == 0
%             maxima(i,:) = [];
%         end
%     end
%     
%     
% end
% end
% Delete range of columns
%m3(:,[1:2]) = [];    