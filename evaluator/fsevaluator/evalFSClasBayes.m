function [ AC ] = evalFSClasBayes( X, Y, trainIDX, testIDX, featIDX, numF)
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

if max(Y) - min(Y) <= 1
    bayesOptions.D = false;
    bayesOptions.K = true;
else
    bayesOptions.D = true;
    bayesOptions.K = false;
end

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
    
    trX = newX(trainIDX,:); trY = Y(trainIDX,:);
    tsX = newX(testIDX,:); tsY = Y(testIDX,:);
    
    %By not passing in an 'options' parameter, we are going with the
    %default supervised parameter 'D'.
    AC(i) = Bayes_CV_estimate(trX,trY,tsX,tsY,bayesOptions);

    fprintf('total features: %5i,   select features: %5i,   Bayes acc value: %.3f\n', size(trX,2), l, AC(i));
    if oversel && ~cal
        cal = 1;
    end
end