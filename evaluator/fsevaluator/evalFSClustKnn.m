function [ ACC ] = evalFSClustKnn( X, Y, wFeat, orderIndicator, numF, maxSel )
%[ res ] = evalFSClustKnn( X, Y, wFeat, orderIndicator, numF )
%   evaluate the feature quality for unsupervised feature selection
%   using both labeled data and unlabeled data
%   X- the data, each row is an instance
%   Y- the labels of the data
%   wFeat - the weight of features
%   orderIndicator - 1:small to big, -1:big to small
%   numF- the array of the feature number we want to try.
resknn = zeros(length(numF),1);

if nargin < 6
    maxSel = max(numF) + 1;
end

[foo, orderIdx] = sort(wFeat*orderIndicator);
for i = 1:length(numF)
    if numF(i) > size(X,2) || numF(i) > maxSel
        resknn(i) = resknn(i-1);
        continue;
    end
    new_X = X(:,orderIdx(1:numF(i)));
    dat = SY2MY(new_X, Y);
    kn = knn();
    kn.algorithm.verbosity = 0;
    CrV = cv(kn);
    CrV.algorithm.verbosity = 0;
    tmp = get_mean(train(CrV,dat));
    tt = tmp.child{1}.Y;
    resknn(i) = (1 - tt(1));
    
    fprintf('num of feauture: %5i, knn acc: %5.3f\n', numF(i), resknn(i));
end
disp(' ');
ACC = resknn;