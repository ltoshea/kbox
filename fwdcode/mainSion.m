global PNUM;
PNUM = 2;
debug = 0;
%Load all data into cell array for easy access
C = cell(PNUM,1);

%Hip centre is first joint


for i=1:PNUM
    path = ['C:\Users\liam\Desktop\KINECT\kbox\data\' num2str(i) '\'];
    data = loadKinectData4(path,1); % 1 = normalise for position, based on hip joint
    %data = loadKinectData2(path);  
    %data = diff(data,1,2); %Columnwise Differentiation - Remove effect of distance from Kinect
    dataAll(i).data = data;
    %dataAll(i).labels to do  
    
    if debug
        close all
        for i=1:size(data,2)
            cla
            a = data(:,i);
            for j=1:3:length(a)
                plot3(a(j),a(j+2),a(j+1),'.');
                hold on
            end
              set(gca,'XLim',[-1 1]);
            set(gca,'YLim',[-1 1]);
            set(gca,'ZLim',[-1 1]);
            pause
        end
    end
    
end

% Big data matrix
M=[];
for i = 1:length(dataAll(i))
    M = [M, dataAll(i).data];, 
end

[Xm1,EV1,Ev1]=createES(M,3);
close all
for i=1:PNUM
    dataAll(i).jred=reconstructPose(dataAll(i).data,Xm1,EV1);
    dataAll(i).jredSmooth = kinsmooth(dataAll(i).jred);
    
end



%For every category of punch
for i=1:PNUM
% 
%     %Create Eignen Spaces for Both
%     [Xm1,EV1,Ev1]=createES(C{i},3);
% 
%     %Reconstruct the data - Output Principal components.
%     jred=reconstructPose(C{i},Xm1,EV1);
% 
    %Smooths PC1,PC2,PC3 and outputs. Removes rest of data.
    %C{i} = kinsmooth(jred);
    % Min/Max of smoothed curve
   % [zmax,zmin,imax,imin] = getminmax(dataAll(i).jredSmooth);
     [zmax,imax,zmin,imin] = getminmax(dataAll(i).jredSmooth,i); %imax = frame no, %zmax = 

    % [zmax,zmin,imax,imin] = findfit2(Z2);
    maxima = vertcat(imax,zmax)';
    maxima = sortrows(maxima,1);

    %Need to normalise graph # Might not need to do this anymore
    %divframes = max(max(imin),max(imax))/size(M1,2);

    %Segement punches & resample
    k = 2;
    SPP = 10;
    framenum = linspace(maxima(k,1),maxima(k+1,1),SPP);
    for k=3:1:length(maxima)-1
        framenum = vertcat(framenum,linspace(maxima(k,1),maxima(k+1,1),SPP));
    end
    framenum = round(framenum); 
    framenum_sort = sort(framenum(:,1));

    % Runs a Dimensional Reduction comparison 
    %DRcomp(M1);

    %gets punch features & resizes for processing with neural networks.
    punchfeat = dataAll(i).jredSmooth(:,framenum);
    %Going to try with PC1 only
    %punchfeat([3],:) = [];
    
    rowno = ceil(((size(punchfeat,1)*size(punchfeat,2)))/30);
    dataAll(i).jredSmooth = reshape(punchfeat',30,rowno)';
end

labels = zeros(111,1)
labels(112:352,:) = ones(241,1)
nninput = horzcat(dataAll(1).jredSmooth,dataAll(2).jredSmooth)

% 
% label = cell(PNUM,1);
% 
% %Creating relevant labels for each punch
% for i=1:length(label)
%     label{i} = repmat(i,length(C{i}),1);
% end
% %Concating labels into single M
% input{1} = C{1};
% for i=2:length(label)
%      label{1} = vertcat(label{1},label{i});
%      input{1} = vertcat(input{1},C{i});
% end
% 
% finalinput = input{1};
% finalbl = label{1};
% %finalbl = num2str(finalbl);
% 
% %Concats labels & data into one M
% % final{1} = input{1};
% % for i=2:length(label)
% %     final{1} = vertcat(final{1},input{i});
% % end








