global PNUM;
PNUM = 1;
debug = 0;
NORM = 1; %flag=1 normalise for hip centroid
clearvars dataAll
clearvars X
clearvars Y

%Hip centre is first joint


for i=1:PNUM
    path = ['C:\Users\liam\Desktop\KINECT\kbox\data\newdata\'];
    data = loadKinectData(path,NORM); %flag=1 normalise for hip centroid
    dataAll(i).data = data;
    
    if 0
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
    M = [M, dataAll(i).data]; 
end

% [Xm1,EV1,Ev1]=createES(M,3); %Create Eigenspace., New data !contribute to eigenspace
%close all
for i=1:PNUM
    dataAll(i).jred=reconstructPose(dataAll(i).data,Xm1,EV1);
    dataAll(i).jredSmooth = kinsmooth(dataAll(i).jred);
    [valmax,imax,valmin, imin] = getminmax(dataAll(i).jredSmooth(1,:),6,NORM); %ERROR, BUG, CHANGE THIIS
   
   % distance = pythagoras(sort(imax)); Going to put in getminmax
    [dataAll(i).imax, a]= sort(imax);
    
    
end
%DRcomp(dataAll(1).jredSmooth());

for i=1:PNUM
    figure
    hold on;
    plot(dataAll(i).jred(1,:),'-r');
    plot(dataAll(i).jredSmooth(1,:),'b');
    plot(dataAll(i).imax, dataAll(i).jredSmooth(1,dataAll(i).imax),'.g');
end

nsamples = 10;

X = [];
Y = [];
lbl = [];
%close all
for i=1:PNUM
    nelem = length(dataAll(i).imax);
    dataAll(i).labels = ones(nelem,1) * i;
    dataAll(i).features = zeros(nelem,nsamples);
    for j = 1:nelem - 1
        inds = round(linspace(dataAll(i).imax(j), dataAll(i).imax(j+1), nsamples));
        dataAll(i).features(j,:) = dataAll(i).jred(1,inds);
        
        if debug
            plot(dataAll(i).features(j,:))
            pause
        end
    end
    
   X = [X;dataAll(i).features];
   Y = [Y;dataAll(i).labels];
   lbl = [lbl;ceil(0.2*(length(dataAll(i).labels)))]; %for labels
   %lbl = ceil(lbl);
end


%'autoscale' is true by default 'kernel_function' 'rbf'
%svmStruct = svmtrain(X(trainInds,:),Y(trainInds),'kernel_function', 'rbf','autoscale','true');
%  svmStruct = svmtrain(Y(trainInds),X(trainInds,:),['-b 1']);
%  labels = zeros(182,1);
 Y = zeros(size(X,1),1);
 [predicted_label, accuracy, probest] = svmpredict(Y,X,svmStruct,['-b 1']);
 %close all
 
%%
%NVarToSample, 'all' deciscion tree, otherwise random forest
%X = M';
% B = TreeBagger(75,X(trainInds,:),Y(trainInds),'OOBPred','On');
C = B.predict(X);
C = cellfun(@str2num,C);
%testlabels(end,:) = [];
% diff = size(testlabels,1) - size(C,1);
% if diff ~= 0
%     testlabels(end-(diff-1):end,:) = [];
% end
% chklbl = horzcat(testlabels,C);
% 
% count=0;
% for i=1:length(C)
%     if chklbl(i,1) == chklbl(i,2)
%         count = count+1;
%     end
% end
% correct = (count/length(C))*100;
% sprintf('Random Forest Correct: %f%%', correct)
%%

%Diffusion maps


%mappedA = compute_mapping(A, type, no_dims, parameters)
 
% C = svmclassify(svmStruct,X(testInds,:),'showplot',true);
%[C, Y(testInds)]

% ty = Y(testInds);
% count = 0;
% for i=1:length(C)
%     if C(i) == ty(i)
%         count = count+1;
%     end
% end
% correct = (count/length(C))*100
% sprintf('Correct: %f%%', correct)
        

%Neural networks
% lbl1 = size(dataAll(1).features,1); %How many punches do we have?
% lbl2 = size(dataAll(2).features,1);
% %lbl2=0;
% totalsize = lbl1+lbl2;
% labels = zeros(lbl1,1);
% labels(lbl1+1:totalsize,:) = ones((totalsize-lbl1),1);
%test_labels = labels(1:40,:); %new addition for test data for SVM
%close all

