function [labels] = gennlabels(Y)

for i=1:6
    switch i
        case 1 
            lbl = [1,0,0,0,0,0];
            testlbl = repmat(lbl,10,1);
            labels(1:10,:) = testlbl;
        case 2
            lbl = [0,1,0,0,0,0];
            testlbl = repmat(lbl,10,1);
            labels(11:20,:) = testlbl;
        case 3
            lbl = [0,0,1,0,0,0];
            testlbl = repmat(lbl,10,1);
            labels(21:30,:) = testlbl;
        case 4
            lbl = [0,0,0,1,0,0];     
            testlbl = repmat(lbl,10,1);
            labels(31:40,:) = testlbl;
        case 5
            lbl = [0,0,0,0,1,0];
            testlbl = repmat(lbl,10,1);
            labels(41:50,:) = testlbl;
        case 6
            lbl = [0,0,0,0,0,1];
            testlbl = repmat(lbl,10,1);
            labels(51:length(Y),:) = testlbl;
    end
end