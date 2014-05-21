function [zmax,imax,zmin,imin] = getminmax(Z2,pno,NORM)
%pno = punch number
%    ZMAX - maxima points in descending order
%    IMAX - indexes of the XMAX
%    ZMIN - minima points in descending order
%    IMIN - indexes of the XMIN

[zmax,imax,zmin,imin] = extrema(Z2(1,:));


%Right handed punches seem to have a different profile (higher amplitude) than left 

if (NORM == 0)
    
    if (pno == 1)
        imax(zmax < -0.0) = [];

    if (pno == 2) | (pno == 4) 
        sortp = [imax;zmax];
        [d1,d2] = sort(sortp(1,:));
        sortp2 = sortp(:,d2); %imax,zmax are now sorted, Need to fix pythag now.
        sortp2 = sortp2(:,(sortp2(2,:) > 0.2)); % Get rid of all points < 0.2
        tvar=pythagoras2(sortp2,NORM);
        imax = tvar(1,:);
        zmax = tvar(2,:);
    end

    if pno==3
        sortp = [imax;zmax];
        [d1,d2] = sort(sortp(1,:));
        sortp2 = sortp(:,d2); %imax,zmax are now sorted, Need to fix pythag now.
        sortp2 = sortp2(:,(sortp2(2,:) > 0.2)); % Get rid of all points < 0.2
        tvar=pythagoras(sortp2,NORM);
        imax = tvar(1,:);
        zmax = tvar(2,:);
        %plot(imax,zmax);
    end
    %pause
    if (pno==5)
        sortp = [imax;zmax];
        [d1,d2] = sort(sortp(1,:));
        sortp2 = sortp(:,d2); %imax,zmax are now sorted, Need to fix pythag now.
        sortp2 = sortp2(:,(sortp2(2,:) > -0.15)); % Get rid of all points < 0.15
        tvar=pythagoras(sortp2,NORM);
        imax = tvar(1,:);
        zmax = tvar(2,:);

    end

    if (pno==6)
        sortp = [imax;zmax];
        [d1,d2] = sort(sortp(1,:));
        sortp2 = sortp(:,d2); %imax,zmax are now sorted, Need to fix pythag now.
        sortp3 = sortp2(:,(sortp2(2,:) > -0.3)); % Get rid of all points < 0.15
        tvar=pythagoras(sortp3,NORM);
        imax = tvar(1,:);
        zmax = tvar(2,:);

    end
    end
end

if (NORM == 1)
     START1=1;
     END1=19;
     
    if (pno == 0)
        sortp = [imax;zmax];
        [d1,d2] = sort(sortp(1,:));
        d1(:,1) = [];
        d2(:,1) = [];
        sortp2 = sortp(:,d2); %imax,zmax are now sorted, Need to fix pythag now.
        sortp3 = sortp2(:,(sortp2(2,1:19) > 0.05)); % Get rid of all points < 0.4
        %%range = length(sortp2);
        sortp4 = sortp2(:,(sortp2(2,:) > 0.35)); % Get rid of all points < 0.4
        %%sortp4(:,[1:19]) = [];
        sortp5 = horzcat(sortp3,sortp4);
        tvar=pythagoras3(sortp5,NORM);
        
        imax = tvar(1,:);
        zmax = tvar(2,:);
        
        
        ind = find(zmax(:,[12:18]) < 0.8) +11;
        imax(:,ind) = [];
        zmax(:,ind) = [];
        
        
%         extras for demo  
    end

%     if (pno == 0)
%         sortp = [imax;zmax];
%         [d1,d2] = sort(sortp(1,:));
%         d1(:,1) = [];
%         d2(:,1) = [];
%         sortp2 = sortp(:,d2); %imax,zmax are now sorted, Need to fix pythag now.
%         sortp2= sortp2(:,(sortp2(2,:) > 0.35)); % Get rid of all points < 0.35
%         
%         sortp3 = [sortp2(:,(sortp2(2,1:19) > 0.05)) sortp2(:,20:end)]; % Get rid of all points < 0.05
%         %%range = length(sortp2);
%         
%         %%sortp4(:,[1:19]) = [];
%         %sortp5 = horzcat(sortp3,sortp4);
%         tvar=pythagoras3(sortp3,NORM);
%         
%         imax = tvar(1,:);
%         zmax = tvar(2,:);
%         
%         
%         ind = find(zmax(:,[12:18]) < 0.8) +11;
%         imax(:,ind) = [];
%         zmax(:,ind) = [];
%         
%         
% %         extras for demo  
%     end


    if (pno == 1)
        imax(zmax < 0.015) = [];
    end

    if (pno == 2) | (pno == 4) 
        sortp = [imax;zmax];
        [d1,d2] = sort(sortp(1,:));
        sortp2 = sortp(:,d2); %imax,zmax are now sorted, Need to fix pythag now.
        sortp2 = sortp2(:,(sortp2(2,:) > 0.6)); % Get rid of all points < 0.4
        tvar=pythagoras2(sortp2,NORM);
        imax = tvar(1,:);
        zmax = tvar(2,:);
    end

    if pno==3
        sortp = [imax;zmax];
        [d1,d2] = sort(sortp(1,:));
        sortp2 = sortp(:,d2); %imax,zmax are now sorted, Need to fix pythag now.
        sortp2 = sortp2(:,(sortp2(2,:) > 0.3)); % Get rid of all points < 0.3
        tvar=pythagoras(sortp2,NORM);
        imax = tvar(1,:);
        zmax = tvar(2,:);
        %plot(imax,zmax);
    end
    %pause
    if (pno==5)
        sortp = [imax;zmax];
        [d1,d2] = sort(sortp(1,:));
        sortp2 = sortp(:,d2); %imax,zmax are now sorted, Need to fix pythag now.
        sortp2 = sortp2(:,(sortp2(2,:) > 0.35)); % Get rid of all points < 0.3
        tvar=pythagoras(sortp2,NORM);
        imax = tvar(1,:);
        zmax = tvar(2,:);

    end

    if (pno==6)
        sortp = [imax;zmax];
        [d1,d2] = sort(sortp(1,:));
        sortp2 = sortp(:,d2); %imax,zmax are now sorted, Need to fix pythag now.
        sortp2 = sortp2(:,(sortp2(2,:) > 0.5)); % Get rid of all points < 0.5
        tvar=pythagoras(sortp2,NORM);
        imax = tvar(1,:);
        zmax = tvar(2,:);

    end
end
end

%imax = sort(imax);
%imax = pythagoras(imax);
%if length(imax) > 1
    %imax(:,end) = []; %Manually making sure we have same number of min and max points.
    %zmax(:,end) = [];
%end

     



