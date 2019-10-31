function [ trainX, trainY, testX, testY, trIDX, tsIDX ] = CVgen( X, Y, idx, maxfold, fold )
%function [ trainX, trainY, testX, testY ] = CVgen( X, Y, idx, maxfold, fold )
%   CVgen generate data for n-folds cross-validation.
%   X, - the data, each row is an instance
%   Y, - the class label. use single colum form.
%   idx, - the random index generated for shuffling the data
%   maxfold - the maxium fold number n
%   fold - the number of current fold
%----
% trainX trainY testX testY - the trainning and testing data.
%

if(length(Y) ~= length(idx))
    disp('the length of the index does not match that of the class label vector');
end

perFold = floor(length(idx)/maxfold);
testIDX = [perFold*(fold-1)+1:perFold*fold];
trainIDX = setdiff(idx, testIDX);

trainX = X(idx(trainIDX),:);
trainY = Y(idx(trainIDX),:);
testX = X(idx(testIDX),:);
testY = Y(idx(testIDX),:);

trIDX = idx(trainIDX);
tsIDX = idx(testIDX);
