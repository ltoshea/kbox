%M1 = Raw Data
%M2 = Differntiate

%  path = ['C:\Users\liam\Desktop\KINECT\kbox\data\1\'];
%     %path = ['C:\Users\liam\Desktop\KINECT\kbox\data\jabtest\' num2str(i) '\'];
%     
%     
%     data = loadKinectData(path,NORM); %flag=1 normalise for hip centroid
%     %data = diff(data,1,2); %Columnwise Differentiation - Remove effect of distance from Kinect
%     dataAll(i).data = data;
    
M1 = loadKinectData('C:\Users\liam\Desktop\KINECT\kbox\data\1\',1);
M2 = diff(M1,1,1);
%M2(1:end,10)=[];


%Create Eignen Spaces for Both
[Xm1,EV1,Ev1]=createES(M1,3);
[Xm2,EV2,Ev2]=createES(M2,3);

%Reconstruct the data
Z1=reconstructPose(M1,Xm1,EV1);
Z2=reconstructPose(M2,Xm2,EV2);

%Smooth Both inputs
Ms1 =smooth(Z1);
Ms1 = reshape(Ms1,[],3)';
Ms2 =smooth(Z2);
Ms2 = reshape(Ms2,[],3)';

X = ceil(length(Z2)/30);

% Min/Max of smoothed curve
[zmax,zmin,imax,imin] = findfit2(Z2);

%Try other dimensionality reduction techniques
%[M1, labels] = generate_data('swiss', 2000, 0.05);
d = round(intrinsic_dim(M1));
Y1 = compute_mapping(M1, 'LLE');
Y2 = compute_mapping(M1, 'LLE', d, 7);
Y3 = compute_mapping(M1, 'Laplacian', d, 7, 'JDQR');
%Y4 = compute_mapping(M1, 'LTSA', d, 7);
Y5 = compute_mapping(M1, 'CCA' , d, 'Matlab');
Y6 = compute_mapping(M1,'PCA',d);

subplot(3, 2, 1), scatter3(M1(1,:), M1(2,:), M1(3,:), 5);
subplot(3, 2, 2), scatter(Y1(:,1), Y1(:,2), 5);
subplot(3, 2, 2), scatter(Y2(:,1), Y2(:,2), 5);
subplot(3, 2, 3), scatter(Y3(:,1), Y3(:,2), 5);
subplot(3, 2, 4), scatter(Y4(:,1), Y4(:,2), 5);
subplot(3, 2, 5), scatter(Y5(:,1), Y5(:,2), 5);
subplot(3, 2, 6), scatter(Y6(:,1), Y6(:,2), 5);



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
