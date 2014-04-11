A = loadKinectData2();

%Remove initial 0 value
%M(1:1,:) = [];
[Xm,EV,Ev]=createES(A,3);
U = EV;
i = 1;
%reconstructBeaks(M,Xm,EV);
