global PNUM;
PNUM = 6;
% global COMP;
COMP=6;
debug = 0;
NORM = 1; %flag=1 normalise for hip centroid
%Hip centre is first joint


for i=1:PNUM
    path = ['C:\Users\liam\Desktop\KINECT\kbox\data\freshdata\' num2str(i) '\'];
    %path = ['C:\Users\liam\Desktop\KINECT\kbox\data\1\'];
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

[Xm1,EV1,Ev1]=createES(M,COMP); %Create Eigenspace., New data !contribute to eigenspace
%close all
for i=1:PNUM
    dataAll(i).jred=reconstructPose(dataAll(i).data,Xm1,EV1);
    dataAll(i).jredSmooth = kinsmooth2(dataAll(i).jred);
    [valmax,imax,valmin, imin] = getminmax(dataAll(i).jredSmooth(1,:),i,NORM);
   
   % distance = pythagoras(sort(imax)); Going to put in getminmax
    [dataAll(i).imax, a]= sort(imax);
    
    
end
%DRcomp(M(:,1:10));



% for i=1:PNUM
%     figure
%     hold on;
%     plot(dataAll(i).jred(1,:),'-r');
%     %plot(M(1,:),'y');
%     %plot(dataAll(i).jred(1,:),'b');
%     %plot(dataAll(i).imax, dataAll(i).jred(1,dataAll(i).imax),'.g');
% end
% 
for i=1:PNUM
    figure
    hold on;
    plot(dataAll(i).jred(1,:),'-r');
    plot(dataAll(i).jredSmooth(1,:),'b');
    plot(dataAll(i).imax, dataAll(i).jredSmooth(1,dataAll(i).imax),'.g');
end
% figure
% hold on
% plot(dataAll(4).jred(1,:),'-r');
% plot(dataAll(4).jredSmooth(1,:),'b');
% plot(dataAll(4).imax, dataAll(4).jredSmooth(1,dataAll(4).imax),'.g');



tilefigs();
pause;
% close all;

nsamples = 15;
X = [];
Y = [];
lbl = [];
%close all
for i=1:PNUM
    nelem = length(dataAll(i).imax);
    dataAll(i).labels = ones(nelem,1) * i;
    dataAll(i).features =  zeros(nelem,nsamples * COMP);%HERE
    for j = 1:nelem - 1
        inds = round(linspace(dataAll(i).imax(j), dataAll(i).imax(j+1), nsamples));
        %dataAll(i).features(j,:) = dataAll(i).jred(1,inds);
        foo = dataAll(i).jred(1:COMP,inds);%HERE
        dataAll(i).features(j,:) = foo(:);%HERE
        
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


trainPercent = 0.8;
trainInds = randperm(length(Y));
trainInds(round(length(Y)*0.8):end) = [];
testInds = 1:length(Y);
testInds(trainInds) = [];

%'autoscale' is true by default 'kernel_function' 'rbf'
% svmStruct = svmtrain(X(trainInds,:),Y(trainInds),'kernel_function', 'rbf','autoscale','true');
 svmStruct = svmtrain(Y(trainInds),X(trainInds,:),['-b 1']);
 %labels = zeros(182,1);
 [predicted_label, accuracy, probest] = svmpredict(Y(testInds),X(testInds,:),svmStruct,['-b 1']);
 %close all
 
%%
%Random forest  label generation. 
 testlabels = [];
 for i=1:6 %should be 6
     temp = repmat(dataAll(i).labels(i,1),lbl(i,1),1);
     testlabels = vertcat(testlabels,temp);
 end
 
 
%NVarToSample, 'all' deciscion tree, otherwise random forest
%X = M'; %Changed this, this is full pose pose.
B = TreeBagger(75,X(trainInds,:),Y(trainInds),'OOBPred','On', 'NVarToSample',5);
C = B.predict(X(testInds,:));
C = cellfun(@str2num,C);

testlabels(end,:) = [];
diff = size(testlabels,1) - size(C,1);

if diff < 0
    for i=1:abs(diff)
    testlabels = vertcat(testlabels,6);
    end
end
    if diff > 0
       testlabels(end-(diff-1):end,:) = [];
    end
chklbl = horzcat(testlabels,C);

count=0;
for i=1:length(C)
    if chklbl(i,1) == chklbl(i,2)
        count = count+1;
    end
end
correct = (count/length(C))*100;
sprintf('Decision Correct: %f%%', correct)

% X = X';
% for i=1:length(X)
%     drel(i)  = dtw(X(:,1),X(:,i));
% end
% % close all
% %Diffusion Maps
% %dtw
% close all
% mappedX = diffusion_maps(X,3,1,1);


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
        


