function [ Zsmooth ] = kinsmooth( Z2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%Smooth all PC1's with other PC1's, PC2's with other PC2s etc..
smoothpc1 = smooth(Z2(1,:),10)';
smoothpc2 = smooth(Z2(2,:),10)';
smoothpc3 = smooth(Z2(3,:),10)';

Zsmooth = vertcat(smoothpc1,smoothpc2,smoothpc3);

%Draw graphs showing smoothed and unsmoothes
figure
hold on
plot(Z2(1,:),'-r');
plot(smoothpc1,'b');
% 
% figure
% hold on
% plot(Z2(2,:),'-r');
% plot(smoothpc2,'b');
% 
% figure
% hold on
% plot(Z2(3,:),'-r');
% plot(smoothpc3,'b');

%pause

end
