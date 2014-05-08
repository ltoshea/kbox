global PNUM;
PNUM = 1;
debug = 0;
NORM = 1; %flag=1 normalise for hip centroid
clearvars dataAll
clearvars X
clearvars Y

for i=1:PNUM
    path = ['C:\Users\liam\Desktop\KINECT\kbox\data\newdata\'];
    %path = ['C:\Users\liam\Desktop\KINECT\kbox\data\testhook\' num2str(i) '\'];
    %path = ['C:\Users\liam\Desktop\KINECT\kbox\data\jabtest\' num2str(i) '\'];
    
    
    data = loadKinectData(path,NORM); %flag=1 normalise for hip centroid
    %data = diff(data,1,2); %Columnwise Differentiation - Remove effect of distance from Kinect
    dataAll(i).data = data;
    %dataAll(i).labels to do  
    
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
    %plot(dataAll(i).jred(1,:),'-r');
    plot(dataAll(i).jredSmooth(1,:),'b');
    plot(dataAll(i).imax, dataAll(i).jredSmooth(1,dataAll(i).imax),'.g');
end

nsamples = 30;

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

close all
results = net(X');
%view(results)
            
            
            
%create labels
%labels = zeros(110,1)
%labels(111:350,:) = ones(240,1)

            
            
        

%'autoscale' is true by default 'kernel_function' 'rbf'
%svmStruct = svmtrain(X(trainInds,:),Y(trainInds),'kernel_function', 'rbf','autoscale','true');
%  svmStruct = svmtrain(Y(trainInds),X(trainInds,:),['-b 1']);
%  %labels = zeros(182,1);
%  [predicted_label, accuracy, probest] = svmpredict(Y(testInds),X(testInds,:),svmStruct,['-b 1']);
%  close all
%  
% %%
% %Random forest % label generation. 
%  testlabels = [];
%  for i=1:6 %should be 6
%      temp = repmat(dataAll(i).labels(i,1),lbl(i,1),1);
%      testlabels = vertcat(testlabels,temp);
%  end
%NVarToSample, 'all' deciscion tree, otherwise random forest
% X = M';
% B = TreeBagger(75,X(trainInds,:),Y(trainInds),'OOBPred','On');
% C = B.predict(X(testInds,:));
% C = cellfun(@str2num,C);
% %testlabels(end,:) = [];
% if length(testlabels) ~= length(C)
%     diff = length(testlabels) - length(C);
%     testlabels([end-(diff-1):end],:) = [];
% end
% 
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
% close all;
% %C = confusionmat(testlabels,predicted_label);
% lbl = [1,2,3,4,5,6];
% cm = confusionmat(testlabels,predicted_label);
% disp(cm);
% heatmap(cm, lbl, lbl,'%0.0f', 'Colormap','money','ShowAllTicks',1,'UseFigureColorMap',true,'Colorbar',true);
% plotconfmat(cm,lbl);

%imagesc(cm);
%colorbar;

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

