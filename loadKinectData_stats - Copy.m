
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
%




function [finalM] =loadKinectData_stats(root_folder)

d = dir([root_folder, 'kin*.txt']);
col = zeros(20,1);
finalM = [];

for j = 1:length(d)
    
    ifp1 = fopen([root_folder,d(j).name],'r');
    
    
    while 1
        %Read whole file into s
        s= fgets(ifp1);
        if s == -1
            break;
        end
        %Each a is 80 data points: Inferred,x,y,z,
        a = sscanf(s(find(s == ' ') + 1:end),'%f');
        %cla
        cnt = 1;
        for i=1:4:length(a)
            col(cnt) = a(i);               
            cnt = cnt + 1;
        end
        
        finalM = [finalM, col];
          
    end
    fclose(ifp1);
    
end






