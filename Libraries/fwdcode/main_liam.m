global PNUM; %Punch number 1-6
PNUM = 2;
global PCNUM;%Number of principal coefficients used for classification
PCNUM=1;
debug = 0;
%Load all data into cell array for easy access
C = cell(PNUM,1);

%Hip centre is first joint


for i=1:PNUM
    path = ['C:\Users\liam\Desktop\KINECT\kbox\data\' num2str(i) '\'];
    data = loadKinectData4(path,1); % 1 = normalise for position, based on hip joint. HIP JOINT CO-ORDS WILL BE 
    %data = diff(data,1,2); %Row-wise Differentiation - Remove effect of distance from Kinect
    data(:,end) = []; %cut off last frame
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
%Create Eignen Spaces
[Xm1,EV1,Ev1]=createES(M,3); %Also does PCA
close all
for i=1:PNUM
    dataAll(i).jred=reconstructPose(dataAll(i).data,Xm1,EV1);
    dataAll(i).jredSmooth = kinsmooth(dataAll(i).jred); 
end



%For every category of punch
for i=1:PNUM
% 
%     %Create Eignen Spaces 
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
    maxima = segpunch(maxima,i);
    
    % Plots min/max on smoothed curve
    figure
    hold on;
    plot(maxima(:,1),maxima(:,2),'r*',(imin),zmin,'g*');
    plot(dataAll(i).jredSmooth(1,:),'.b-');

    %Going to use maxima as a classifier
    dataAll(i).thcount = 0; 
    for i=1:length(maxima)
        if maxima(i,2)> 0.6
            thcount = thcount+1;
        end
    end




    %Segement punches & resample
    SPP =30;
    framenum = linspace(maxima(1,1),maxima(2,1),SPP);
    for k=2:1:length(maxima)-1
        framenum = vertcat(framenum,linspace(maxima(k,1),maxima(k+1,1),SPP));
    end
    framenum = round(framenum);
    framenum = framenum(:,1);

    % Runs a Dimensional Reduction comparison 
    %DRcomp(M1);

    %gets punch features & resizes for processing with neural networks.
    punchfeat = dataAll(i).jredSmooth(:,framenum);
    punchfeat([2:3],:) = []; %Different principal coefficients
    
%     figure
%     plot(punchfeat);
    
    rowno = ceil(((size(punchfeat,1)*size(punchfeat,2)))/(SPP*PCNUM));
    dataAll(i).jredSmooth = reshape(punchfeat',(SPP*PCNUM),rowno)';
end
%ORIGINAL nninput = vertcat(dataAll(1).jredSmooth,dataAll(2).jredSmooth);
nninput = vertcat(dataAll(1).jredSmooth(41:end,:),dataAll(2).jredSmooth);
testinput = dataAll(1).jredSmooth(1:40,:)


%%
%Construct labels for training
lbl1 = size(dataAll(1).jredSmooth,1); %How many punches do we have?
lbl2 = size(dataAll(2).jredSmooth,1);
%lbl2=0;
totalsize = lbl1+lbl2;
labels = zeros(lbl1,1);
labels(lbl1+1:totalsize,:) = ones((totalsize-lbl1),1);
test_labels = labels(1:40,:); %new addition for test data for SVM
%%

 SVMStruct = svmtrain(nninput,labels(41:end,:),'kernel_function','mlp','mlp_params',[1 -2]); %poly 60%, rbg 70%, mlp 72.5%, mlp with [1, -2] 75%
 Group = svmclassify(SVMStruct,testinput)
 lbl_group = horzcat(test_labels,Group);

%% Calc SVC effectiveness
count=0;
for i=1:size(lbl_group,1)
    if lbl_group(i) == lbl_group(i,2)
        count = count+1;
    end
end
correct = (count/size(lbl_group,1))*100;
sprintf('Correct: %f%%', correct)
%%

%%
%fft test
 n1 = fft(dataAll(1).jredSmooth(),[],2); %Do the fft row rise
 n2 = fft(dataAll(2).jredSmooth(),[],2);
 n1r = real(n1);
 n2r = real(n2);
 fftcoeff1 = real(sum(sum(n1)));
 fftcoeff2 = real(sum(sum(n2)));
 



%%
%START = 2;
% START = 120;
% %WINDOW = 80;
% dtwval = dtw_2(nninput(START,:),nninput(START,:)); %Will need to transpose nninputs for other DTW function
% for i=START+1:size(nninput,1) %-(START)
%     temp=dtw_2(nninput(START,:),nninput(i,:));
%     dtwval = horzcat(dtwval,temp);
% end
% dtwval = dtwval';
% average = mean(dtwval)
% 'DONE'
% 
%%

% label = cell(PNUM,1);
% 
%Creating relevant labels for each punch
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








