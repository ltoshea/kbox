function [] = DRcomp( M1 )
%DRcomp, Dimensionality Reduction Comparison
%  Plot principal components from several different DR methods
%  and observe the most useful.


%[M1, labels] = generate_data('swiss', 2000, 0.05);
d = findD(M1);
Y1 = compute_mapping(M1', 'LLE')';
Y2 = compute_mapping(M1', 'LLE', d, 7)';
Y3 = compute_mapping(M1', 'Laplacian', d, 7, 'JDQR')';
Y4 = compute_mapping(M1', 'LTSA', d, 7)';
Y5 = compute_mapping(M1', 'CCA' , d, 'Matlab')';
Y6 = compute_mapping(M1','PCA',d)';

figure('name','Dimensional Reduction(DC) Comparison: 1st PC');
suptitle('Dimensional Reduction Comparison: 1st PC');
subplot(3, 2, 1), plot(Y1(1,:));
title('LLE')
subplot(3, 2, 2), plot(Y2(1,:));
title('LLE, with d')
subplot(3, 2, 3), plot(Y3(1,:));
title('Laplacian')
subplot(3, 2, 4), plot(Y4(1,:));
title('LTSA')
subplot(3, 2, 5), plot(Y5(1,:));
title('CCA')
subplot(3, 2, 6), plot(Y6(1,:));
title('PCA')
%Set all the axis for each plot
c=get(gcf,'children'); %get the axes
pos=ones(length(c),4);
xlab='Frame Number';
ylab='PC Value';

%Add the labels to the edge plots
for ii=1:length(c)
    %Add X 
    if pos(ii,2)==min(pos(:,2));
        set(get(c(ii),'xlabel'),'string',xlab)
    end
    %Add Y
    if pos(ii,1)==min(pos(:,1));
        set(get(c(ii),'ylabel'),'string',ylab)
    end
end


figure('name','DR Comparison: 2nd PC');
suptitle('Dimensional Reduction Comparison: 2nd PC');
subplot(3, 2, 1), plot(Y1(2,:));
title('LLE')
subplot(3, 2, 2), plot(Y2(2,:));
title('LLE, with d')
subplot(3, 2, 3), plot(Y3(2,:));
title('Laplacian')
subplot(3, 2, 4), plot(Y4(2,:));
title('LTSA')
subplot(3, 2, 5), plot(Y5(2,:));
title('CCA')
subplot(3, 2, 6), plot(Y6(2,:));
title('PCA')

%Set all the axis for each plot
c=get(gcf,'children'); %get the axes
pos=ones(length(c),4);
xlab='Frame Number';
ylab='PC Value';

%Add labels to the edge plots
for ii=1:length(c)
    %Add X 
    if pos(ii,2)==min(pos(:,2));
        set(get(c(ii),'xlabel'),'string',xlab)
    end
    %Add Y
    if pos(ii,1)==min(pos(:,1));
        set(get(c(ii),'ylabel'),'string',ylab)
    end
end

end

