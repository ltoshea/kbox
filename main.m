
J = loadKinectData2('C:\Users\liam\Desktop\KINECT\kbox\data\jab\'); % Raw data
C = loadKinectData2('C:\Users\liam\Desktop\KINECT\kbox\data\cross\'); % Raw data
M2 = diff(M1,1,1); %Columnwise Differentiation


%Create Eignen Spaces for Both
[Xm1,EV1,Ev1]=createES(M1,3);
[Xm2,EV2,Ev2]=createES(M2,3);

%Reconstruct the data
Z1=reconstructPose(M1,Xm1,EV1);
Z2=reconstructPose(M2,Xm2,EV2);

%Smooth PC1,PC2,PC3
Zsmooth = kinsmooth(Z2);
% Min/Max of smoothed curve
[zmax,zmin,imax,imin] = getminmax(Zsmooth);


% [zmax,zmin,imax,imin] = findfit2(Z2);
maxima = vertcat(zmax,imax)';
maxima = sortrows(maxima,1);

%Need to normalise graph # Might not need to do this anymore
%divframes = max(max(imin),max(imax))/size(M1,2);

%Segement punches & resample
i = 2;
framenum = linspace(maxima(i,1),maxima(i+1,1),20);
for i=3:1:length(maxima)-1
    framenum = vertcat(framenum,linspace(maxima(i,1),maxima(i+1,1),20));
end
%framenum = round(framenum(:)); 
framenum = round(framenum); 
framenum_sort = sort(framenum(:,1));

%Need framenum in column vector 
%framenum = framenum';

%points = ordered set of maximum points on smoothed curve.
%points(:,[2:end]) = []; THIS FUCKS IT UP

% Runs a Dimensional Reduction comparison 
%DRcomp(M1);


jabfeat = Zsmooth(:,framenum); %get features
rowno = ceil(((size(jabfeat,1)*size(jabfeat,2)))/60);
test = reshape(jabfeat',60,rowno)';

%jabfeat=reshape(jabfeat,[],60)
%label = ones(length(jabfeat),1); %Add a column of 1's to jabfeatures
%jabfeat = [label,jabfeat];

%feat1 = Z2(:,inds);






%%
%Graph non smoothed data
%hold on
% plot(Z1(1,:),'g')
% plot(Z2(1,:),'b')
% %Smoothed Raw & Differntiated data
% plot(Ms1(1,:),'r')
% plot(Ms2(1,:),'k')
%plot(Zs2(1,:))

%  figure();
%  hold on;
%  plot(Z1(1,:),'g');
%  plot(Z2(1,:),'r');
%  
%  figure();
%  hold on;
%  plot(Z1(2,:),'g');
%  plot(Z2(2,:),'r');
%  
%  figure();
%  hold on;
%  plot(Z1(3,:),'g');
%  plot(Z2(3,:),'r');