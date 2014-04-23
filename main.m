global PNUM;
PNUM = 2;

%Load all data into cell array for easy access
C = cell(PNUM,1);

for i=1:PNUM
    path = ['C:\Users\liam\Desktop\KINECT\kbox\data\' num2str(i) '\'];
    data = loadKinectData2(path);
    data = diff(data,1,2); %Row-wise Differentiation - Remove effect of distance from Kinect
    C{i} = data;
end

% for i=1:PNUM
%     test = diffmap(C{i});
% end


%For every category of punch
for i=1:PNUM

    %Create Eignen Spaces for Both
    [Xm1,EV1,Ev1]=createES(C{i},3);

    %Reconstruct the data - Output Principal components.
    jred=reconstructPose(C{i},Xm1,EV1);

    %Smooths PC1,PC2,PC3 and outputs. Removes rest of data.
    C{i} = kinsmooth(jred);
    % Min/Max of smoothed curve
    [zmax,zmin,imax,imin] = getminmax(C{i});

    % [zmax,zmin,imax,imin] = findfit2(Z2);
    maxima = vertcat(zmax,imax)';
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
    punchfeat = C{i}(:,framenum); %Each column 3xpc for each frame
    %Going to try with PC1 only
    %punchfeat([3],:) = [];
    
    rowno = ceil(((size(punchfeat,1)*size(punchfeat,2)))/30);
    C{i} = reshape(punchfeat',30,rowno)';
end

label = cell(PNUM,1);

%Creating relevant labels for each punch
for i=1:length(label)
    label{i} = repmat(i,length(C{i}),1);
end
%Concating labels into single M
input{1} = C{1};
for i=2:length(label)
     label{1} = vertcat(label{1},label{i});
     input{1} = vertcat(input{1},C{i});
end

finalinput = input{1};
finalbl = label{1};
%plot(finalinput) %WHAT!?

%Dynamic time warp. Need to transpose as expecting in column format, not
%row.
dtwval = dtw(finalinput(6,:)',finalinput(6,:)');
for i=7:length(finalinput)-6
    temp=dtw(finalinput(6,:)',finalinput(i,:)');
    dtwval = horzcat(dtwval,temp);
end
dtwval = dtwval';

%finalbl = num2str(finalbl);

%Concats labels & data into one M
% final{1} = input{1};
% for i=2:length(label)
%     final{1} = vertcat(final{1},input{i});
% end








