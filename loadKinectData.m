%root_folder = 'C:\Users\liam\Desktop\KINECT\SionTest\';
root_folder = 'C:\Users\liam\Desktop\KINECT\';
d = dir([root_folder, 'kin*.txt']);
m = dir([root_folder, 'meta*.txt']);

%for each kinect file
for j = 1:length(d)
    
    ifp1 = fopen([root_folder,d(j).name],'r');
    ifp2 = fopen([root_folder,m(j).name],'r');
    grapht = d(j).name;
    title(grapht);
    %close all;
    meta = fgets(ifp2);
    
    
    while 1

        %Read whole file into s
        s= fgets(ifp1);
        if s == -1
            break;
        end
        %Each a is 80 data points: Inferred,x,y,z,
        a = sscanf(s(find(s == ' ') + 1:end),'%f');
        cla;
        
        %for i=1;i<length(a);i+4
        for i=1:4:length(a)
            x = a(i + 1);
            y = a(i + 2);
            z = a(i + 3);
            
            %title(d(j).name);
            plot3(x,z,y,'o');
            hold on
            %title('damn matlab');
            
        end
        set(gca,'XLim',[-1 0]);
        set(gca,'YLim',[-1.1 2]);
        set(gca,'ZLim',[-1.1 2]);
        pause
    end
    
    fclose(ifp1);
    fclose(ifp2);
end
