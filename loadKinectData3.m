%%
%{
i=0:  NUI_SKELETON_POSITION_HIP_
CENTER
i=1:  NUI_SKELETON_POSITION_SPINE
i=2:  NUI_SKELETON_POSITION_SHOULDER_CENTER
i=3:  NUI_SKELETON_POSITION_HEAD
i=4:  NUI_SKELETON_POSITION_SHOULDER_LEFT
i=5:  NUI_SKELETON_POSITION_ELBOW_LEFT
i=6:  NUI_SKELETON_POSITION_WRIST_LEFT
i=7:  NUI_SKELETON_POSITION_HAND_LEFT
i=8:  NUI_SKELETON_POSITION_SHOULDER_RIGHT
i=9:  NUI_SKELETON_POSITION_ELBOW_RIGHT
i=10: NUI_SKELETON_POSITION_WRIST_RIGHT
i=11: NUI_SKELETON_POSITION_HAND_RIGHT
i=12: NUI_SKELETON_POSITION_HIP_LEFT
i=13: NUI_SKELETON_POSITION_KNEE_LEFT
i=14: NUI_SKELETON_POSITION_ANKLE_LEFT
i=15: NUI_SKELETON_POSITION_FOOT_LEFT
i=16: NUI_SKELETON_POSITION_HIP_RIGHT
i=17: NUI_SKELETON_POSITION_KNEE_RIGHT
i=18: NUI_SKELETON_POSITION_ANKLE_RIGHT
i=19: NUI_SKELETON_POSITION_FOOT_RIGHT

Remember matlab index start at 1.
Joint needed = (i+1)*4 // For z value of left hand
%}
%%


%Version 3 puts each matrix in a cell array and does not concatenate them into one giant one%

function [M] =loadKinectData3(root_folder)
%root_folder = 'C:\Users\liam\Desktop\KINECT\kbox\data\';
%root_folder = 'C:\Users\liam\Desktop\KINECT\kbox\testdata\';
%root_folder = 'C:\Users\liam\Desktop\KINECT\kbox\data\1\';
d = dir([root_folder, 'kin*.txt']);
m = dir([root_folder, 'meta*.txt']);
%M = [0,0,0];
M = cell(length(d),1);
%for each kinect file


for j = 1:length(d)
    
    ifp1 = fopen([root_folder,d(j).name],'r');
    ifp2 = fopen([root_folder,m(j).name],'r');
    grapht = d(j).name;
    %title(grapht);
    %close all;
    meta = fgets(ifp2);
    xs = 0;
    ys = 0;
    zs = 0;
    
    while 1

        %Read whole file into s
        s= fgets(ifp1);
        if s == -1
            break;
        end
        %Each a is 80 data points: Inferred,x,y,z,
        a = sscanf(s(find(s == ' ') + 1:end),'%f');
        %cla;
        
        notation = [{'gs'},{'rO'},{'b+'},{'k>'}]; %colour followed by marker
        for i=1:4:length(a)
            x = a(i + 1);
            y = a(i + 2);
            z = a(i + 3);
            
            xs = cat(1,xs,x);
            ys = cat(1,ys,y);
            zs = cat(1,zs,z);
                
            
        end
        
    end 
    xs(1:1,:) = []; %Slice of the padding '0' at top of each
    ys(1:1,:) = [];
    zs(1:1,:) = [];
    temp = cat(2,xs,ys,zs); %concat into column
    %M = vertcat(M,temp);%M = cat(2,xs,ys,zs); %concat into rows
    M{j} = temp;
    M{j}=diff(M{j},1,1); %Columnwise Differentiation - Remove effect of distance from Kinect
    fclose(ifp1);
    fclose(ifp2); 
end






