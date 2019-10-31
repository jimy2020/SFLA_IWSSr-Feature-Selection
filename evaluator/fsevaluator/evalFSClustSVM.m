function [ ACC ] = evalFSClustSVM( X, Y, wFeat, orderIndicator, numF )
%[ res ] = evalFSClustSVM( X, Y, wFeat, orderIndicator, numF )
%   evaluate the feature quality for unsupervised feature selection
%   using both labeled data and unlabeled data
%   X- the data, each row is an instance
%   Y- the labels of the data
%   wFeat - the weight of features
%   orderIndicator - 1:small to big, -1:big to small
%   numF- the array of the feature number we want to try.
resSVM = zeros(length(numF),1);
nY = length(unique(Y));

[foo, orderIdx] = sort(wFeat*orderIndicator);
for i = 1:length(numF)
    if numF(i) > size(X,2)
        break;
    end
    new_X = X(:,orderIdx(1:numF(i)));
    dat = SY2MY(new_X, Y, nY);
    if nY > 2
        sv = one_vs_rest(svm());
    else
        sv = svm();
    end
    sv.algorithm.verbosity = 0;
    CrV = cv(sv);
    CrV.algorithm.verbosity = 0;
    tmp = get_mean(train(CrV,dat));
    tt = tmp.child{1}.Y;
    resSVM(i) = (1 - tt(1));
    
    fprintf('num of feauture: %5i, svm acc: %5.3f\n', numF(i), resSVM(i));
end
disp(' ');
ACC = resSVM;