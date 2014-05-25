global PNUM;
PNUM = 1;
debug = 0;
NORM = 1; %flag=1 normalise for hip centroid
COMP = 6;
clearvars dataAll;
clearvars X;
clearvars Y;
clearvars labels;

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

load M_ORIG
M = [M,M_ORIG]; 

% [Xm1,EV1,Ev1]=createES(M,3); %Create Eigenspace., New data !contribute to eigenspace
for i=1:PNUM
    dataAll(i).jred=reconstructPose(dataAll(i).data,Xm1,EV1);
    dataAll(i).jredSmooth = kinsmooth2(dataAll(i).jred);
    [valmax,imax,valmin, imin] = getminmax(dataAll(i).jredSmooth(1,:),0,NORM); %ERROR, BUG, CHANGE THIIS
   
   % distance = pythagoras(sort(imax)); Going to put in getminmax
   temp = sort(imax); 
   [dataAll(i).imax]= unique(temp);
     
end

%DRcomp(dataAll(1).jredSmooth());

for i=1:PNUM
    figure
    hold on;
    %plot(dataAll(i).jred(1,:),'-r');
    plot(dataAll(i).jredSmooth(1,:),'b');
    plot(dataAll(i).imax, dataAll(i).jredSmooth(1,dataAll(i).imax),'.g');
end


nsamples = 15;
% ncomponents = 3;

X = [];
Y = [];
lbl = [];
%close all
for i=1:PNUM
    nelem = length(dataAll(i).imax);
    dataAll(i).labels = ones(nelem,1) * i;
    dataAll(i).features =  zeros(nelem,nsamples * COMP);
    for j = 1:nelem - 1
        inds = round(linspace(dataAll(i).imax(j), dataAll(i).imax(j+1), nsamples));
        temp = dataAll(i).jred(1:COMP,inds);
        dataAll(i).features(j,:) = temp(:);
        
        if debug
            plot(dataAll(i).features(j,:))
            pause
        end
    end
    
   X = [X;dataAll(i).features];
   Y = [Y;dataAll(i).labels];
   Y = gensvclabels(Y);
   lbl = [lbl;ceil(0.2*(length(dataAll(i).labels)))];
end

 [predicted_label, accuracy, probest] = svmpredict(Y,X,svmStruct,['-b 1']);
 C = B.predict(X);
 C = cellfun(@str2num,C);
 count = 0;

 for i=1:length(C)
     if C(i) == Y(i)
        count = count+1;
    end
end
correct = (count/length(C))*100;
sprintf('Decision Correct: %f%%', correct)
        

