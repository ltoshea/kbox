function [d] = findD(M1)

Mt = M1';
d1 = intrinsic_dim(Mt);
disp(['MLE estimation: ' num2str(d1)]);
d2 = intrinsic_dim(Mt, 'CorrDim');
disp(['Correlation dim. estimation: ' num2str(d2)]);
d3 = intrinsic_dim(Mt, 'NearNbDim');
disp(['NN dim. estimation: ' num2str(d3)]);
d4 = intrinsic_dim(Mt, 'EigValue');
disp(['Eigenvalue estimation: ' num2str(d4)]);
% d5 = intrinsic_dim(Mt, 'PackingNumbers');
% disp(['Packing numbers estimation: ' num2str(d5)]);
d6 = intrinsic_dim(Mt, 'GMST');
disp(['GMST estimation: ' num2str(d6)]);
mu = mean([d1 d2 d3 d4 d6]);
disp(['Mean estimation: ' num2str(mu)]);
d=round(mu);


