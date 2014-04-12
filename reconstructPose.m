%function reconstructBeaks(A, Xm,U)
%U = eigenvectors (EV)
function reconstructPose(A,Xm,U)
for i = 1:size(A, 1)
    %testbeak = A(i,:)';
    testpose = A(:,i);
    a = U'*(testpose-Xm); %% Get projection coefficients
    y = U*a+Xm;
    
    close all;
    hold on;
    plot3(testpose(1:20),testpose(21:40),testpose(41:end),'-gx');
    plot3(y(1:20),y(21:40),y(41:end),'-r');
    %set(gca,'XLim',[0 1000], 'YLim',[200 200]);
    axis equal;
    r = norm(y-testpose);
    fprintf('MSRE batch: %.4f\n', r);
    pause
end
end