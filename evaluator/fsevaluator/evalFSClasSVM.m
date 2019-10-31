function [ AC ] = evalFSClasSVM( X, Y, trainIDX, testIDX, featIDX, numF)
%test the accuracy of the selected features
%   X - The data, each row is an instances
%   Y - The class label
%   featIDX - feature index from important to unimportant
%   numF - the vector contains the different number of features we want to test
%   trainIDX - the idx for training data
%   testIDX - the idx for testing data
%
%===================
%   acc - the accuracy list.
%
AC = zeros(length(numF),1);

oversel = 0; cal = 0;
nY = length(unique(Y));

for i = 1:length(numF)
    
    if numF(i) > sum(featIDX>0)
        oversel = 1; l = sum(featIDX>0);
    else
        l = numF(i);
    end
    
    if cal
        AC(i) = AC(i-1);
        continue;
    end
        
    newX = X(:,featIDX(1:l));
    
    TR = SY2MY(newX(trainIDX,:), Y(trainIDX,:),nY);
    TS = SY2MY(newX(testIDX,:), Y(testIDX,:),nY);
    
    sv=svm;
    sv.algorithm.verbosity = 0;
    if nY > 2
        sv = one_vs_rest(sv);
    end
    sv.algorithm.verbosity = 0;
    [res,resSV] = train(sv,TR);
    acc = test(resSV,TS,'class_loss');
    AC(i) = 1-acc.Y;

    fprintf('total features: %5i,   select features: %5i,   acc value: %.3f\n', size(TR.X,2), l, AC(i));
    if oversel && ~cal
        cal = 1;
    end
end