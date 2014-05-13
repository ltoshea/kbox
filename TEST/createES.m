function [Xm,EV,Ev]=createES(X,K)
	%k = numberof eigenvectors to retain%
	%CREATEES  Create eigenspace.
%   [Xm,EV,Ev] = CREATEES(X) creates an eigenspace from data matrix X.
%   It returns mean image Xm, eigenvectors in columns of EV and eigenvalues Ev.
%   Each column of X is a vector representing an image.

[M N]=size(X);
Xm=mean(X,2);
Xd=X-repmat(Xm,1,N);
if (N < M) %less images than image length
    Q=Xd'*Xd;
    [V L Vt]=svd(Q);
    EV=Xd*V;
    EV=EV./repmat(sqrt(diag(L)'),M,1);
else %more images than image length
    Q=Xd*Xd';
    [EV L Vt]=svd(Q); %EV = unity matrix
end;
Ev=diag(L)'/N;

if nargin>1
    EV=EV(:,1:K);
    Ev=Ev(1:K);
end;
