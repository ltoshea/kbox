global PNUM;
PNUM = 1;
debug = 0;
NORM = 1; %flag=1 normalise for hip centroid
%clearvars dataAll
clearvars X
clearvars Y

for i=1:PNUM
    path = ['C:\Users\liam\Desktop\KINECT\kbox\data\newdata\'];
    %path = ['C:\Users\liam\Desktop\KINECT\kbox\data\testhook\' num2str(i) '\'];
    %path = ['C:\Users\liam\Desktop\KINECT\kbox\data\jabtest\' num2str(i) '\'];
    
    
    data = loadKinectData(path,NORM); %flag=1 normalise for hip centroid
    %data = diff(data,1,2); %Columnwise Differentiation - Remove effect of distance from Kinect
    dataAll(i).testdata = data;
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
M2=[];
for i = 1:length(dataAll(i))
    M = [M, dataAll(i).data]; 
end

for i = 1:length(dataAll(i))
    M2 = [M2, dataAll(i).testdata]; 
end

M = [M M2];

  [Xm1,EV1,Ev1]=createES(M,3); %Create Eigenspace., New data !contribute to eigenspace
%close all
for i=1:PNUM
    dataAll(i).testjred=reconstructPose(dataAll(i).testdata,Xm1,EV1);
    dataAll(i).testjredSmooth = kinsmooth(dataAll(i).testjred);
    [valmax,imax,valmin, imin] = getminmax(dataAll(i).testjredSmooth(1,:),0,NORM); %ERROR, BUG, CHANGE THIIS
   
   % distance = pythagoras(sort(imax)); Going to put in getminmax
   temp = sort(imax);
   [dataAll(i).testimax]= unique(temp);
end


%DRcomp(dataAll(1).jredSmooth());

for i=1:PNUM
    figure
    hold on;
    %plot(dataAll(i).jred(1,:),'-r');
    plot(dataAll(i).testjredSmooth(1,:),'b');
    plot(dataAll(i).testimax, dataAll(i).testjredSmooth(1,dataAll(i).testimax),'.g');
end

nsamples = 10;

Xt = [];
Yt = [];
lbl = [];

%Dealingn with new test data
for i=1:PNUM
    nelem = length(dataAll(i).testimax);
    dataAll(i).testlabels = ones(nelem,1) * i;
    dataAll(i).testfeatures = zeros(nelem,nsamples);
    for j = 1:nelem - 1
        inds = round(linspace(dataAll(i).testimax(j), dataAll(i).testimax(j+1), nsamples));
        dataAll(i).testfeatures(j,:) = dataAll(i).testjred(1,inds);
        
        if debug
            plot(dataAll(i).testfeatures(j,:))
            pause
        end
    end
    
   Xt = [Xt;dataAll(i).testfeatures]; 
   Yt = [Yt;dataAll(i).testlabels];
   lbl = [lbl;ceil(0.2*(length(dataAll(i).testlabels)))]; %for labels
end

% %Dealing with base data
% X = [];
% Y = [];
% for i=1:6
%     nelem = length(dataAll(i).imax);
%     dataAll(i).labels = ones(nelem,1) * i;
%     dataAll(i).features = zeros(nelem,nsamples);
%     for j = 1:nelem - 1
%         inds = round(linspace(dataAll(i).imax(j), dataAll(i).imax(j+1), nsamples));
%         dataAll(i).features(j,:) = dataAll(i).jred(1,inds);
%         
%         if debug
%             plot(dataAll(i).features(j,:))
%             pause
%         end
%     end
%   
    X = [];
    Y = [];
    for i=1:6
        X = [X;dataAll(i).features]; 
        Y = [Y;dataAll(i).labels];
    end
%    lbl = [lbl;ceil(0.2*(length(dataAll(i).labels)))]; %for labels
%    %lbl = ceil(lbl);
% end


Xall = [X;Xt];

labels = zeros(60,6);
for i=1:6
    switch i
        case 1 
            lbl = [1,0,0,0,0,0];
            testlbl = repmat(lbl,10,1);
            labels(1:10,:) = testlbl;
        case 2
            lbl = [0,1,0,0,0,0];
            testlbl = repmat(lbl,10,1);
            labels(11:20,:) = testlbl;
        case 3
            lbl = [0,0,1,0,0,0];
            testlbl = repmat(lbl,10,1);
            labels(21:30,:) = testlbl;
        case 4
            lbl = [0,0,0,1,0,0];     
            testlbl = repmat(lbl,10,1);
            labels(31:40,:) = testlbl;
        case 5
            lbl = [0,0,0,0,1,0];
            testlbl = repmat(lbl,10,1);
            labels(41:50,:) = testlbl;
        case 6
            lbl = [0,0,0,0,0,1];
            testlbl = repmat(lbl,10,1);
            labels(51:60,:) = testlbl;
    end
end


% close all
maxval=[];
maxind=[];
results = net(X');
[maxval maxind] = max(results);
results = zeros(size(results));
for i=1:length(results)
    results(maxind(i),i) = 1;
end
Yall = [dataAll(7).base;Yt];
lblcut = abs(length(results) - length(Yall));
Yall([end-(lblcut-1):end],:) = [];

%m3(:,[1:2]) = [];
figure, plotconfusion(Yall',results)
% %results = sim(net,X');
% 
% 
% 
% 
% net2 = configure(net,X');
% view(net2);
%plot(results2);
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

