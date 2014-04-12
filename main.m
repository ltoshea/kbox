M = loadKinectData2();
[Xm,EV,Ev]=createES(M,3);
reconstructPose(M,Xm,EV);
diffM = diff(M,1,1);