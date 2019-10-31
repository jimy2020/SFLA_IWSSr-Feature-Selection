function [ SVMAC ] = evalFSClasSVMCV( X, Y, trainIDX, testIDX, featIDX, numF)
%test the accuracy of the selected features
%   X - The data, each row is an instances
%   Y - The class label
%   featIDX - feature index from important to unimportant
%   numF - the vector contains the different number of features we want to test
%   trainIDX - the idx for training data
%   testIDX - the idx for testing data
%
%===================
%   SVMAC - the accuracy list of the SVM classifier.
%   BayesAC - the accuracy list of the Bayesian classifier.
%

SVMAC = zeros(length(numF),1);

oversel = 0; cal = 0;

for i = 1:length(numF)
    
    if numF(i) > sum(featIDX>0)
        oversel = 1; l = sum(featIDX>0);
    else
        l = numF(i);
    end
    
    %What in the world does this do?
    if cal
        SVMAC(i) = SVMAC(i-1);
        continue;
    end
        
    newX = X(:,featIDX(1:l));
    
    trX = newX(trainIDX,:); trY = Y(trainIDX,:);
    tsX = newX(testIDX,:); tsY = Y(testIDX,:);
    
    SVMAC(i) = SVM_CV_estimate(trX,trY,tsX,tsY);
    

    fprintf('total features: %5i,   select features: %5i,   SVM acc value: %.3f\n', size(trX,2), l, SVMAC(i));
    if oversel && ~cal
        cal = 1;
    end
end