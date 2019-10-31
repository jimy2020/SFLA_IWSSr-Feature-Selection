function [ X, meanX, nor ] = normData(X, opt, ctr)
% normalize the data,
%   X, the data, each row is an instance
%   opt, 1, normalize feature, 2 normalize instance
%   ctr, 1, centeralize the data

numL = size(X,1);

if nargin >= 3 && ctr == 1
    meanX = mean(X,1);
    X = X - ones(numL,1)*mean(X,1);
end

switch(opt)
    case 1
        % normalize the features of the data
        featNorm = sqrt(sum(X .* X,1));
        zeroIDX = featNorm<eps*1000;
        featNorm = featNorm.^-1;
        featNorm(zeroIDX) = 0;
        X = X.*repmat(featNorm,numL,1);
        nor = featNorm;
    case 2
        % normalize the instances of the data
        InstNorm = sqrt(sum(X .* X,2));
        zeroIDX = InstNorm<eps*1000;
        InstNorm = InstNorm.^-1;
        InstNorm(zeroIDX) = 0;    
        X = repmat(InstNorm,1,size(X,2)).*X;
        nor = InstNorm;
    case 3
end
X(isnan(X)) = 0;
tmpX = X;
tmpX(isinf(X)) = 0;
X(isinf(X)) = max(max(tmpX))*1000;