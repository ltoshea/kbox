global PNUM;
PNUM = 6;
debug = 0;
NORM = 1; %flag=1 normalise for hip centroid
%Hip centre is first joint


for i=1:PNUM
    path = ['C:\Users\liam\Desktop\KINECT\kbox\data\' num2str(i) '\'];
    data = loadKinectData_stats(path); %flag=1 normalise for hip centroid
    dataAll(i).data = data;    
end



for i=1:PNUM
    dataAll(i).tracked = sum(sum(dataAll(i).data == 2))/2;
    dataAll(i).inferred = sum(sum(dataAll(i).data == 1));
end

dataAll().tracked
dataAll().inferred

% u = unique(dataAll(1).data);
% fprintf('%d appears %d times\n', [u; histc(dataAll(1).data,u)].');