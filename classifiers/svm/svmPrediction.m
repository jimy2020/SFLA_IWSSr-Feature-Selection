function [ acc, predict_label ] = svmPrediction( trainX, trainY, testX , testY, ker )
%function [ acc ] = svmPrediction( trainData, testData , ker, method )
%return the accuarcy of the 1nn. 
%input:  trainX, testX, the training and test data, each row is an instance
%        trainY, testY, the label, 1, 2, ...
%        param.ker: 1. linear kernel. 2. RBF
%        param.gamma, param.C [optional]

if length(unique(trainY))==2
    trainY(trainY==2) = -1;
    testY(testY==2) = -1;
end

switch param.ker
    case 1 %Linear
        if isfield(param,'C');
            str = sprintf('-c %f', ker.C);
        end
        model = svmtrain_lib(trainY, trainX, ['-t 0', ' ', str]);

        [predict_label, accuracy] = svmpredict_lib(testY, testX, model);
        acc = accuracy(1);
        
    case 2 %RBF
        if isfield(ker,'C');
            str = sprintf('-c %f', ker.C);
        end
        if isfield(ker,'gamma');
            str = [str sprintf('-g %f', ker.gamma)];
        end
        model = svmtrain_lib(trainY, trainX, ['-t 2', ' ', str]);
 
        [predict_label, accuracy] = svmpredict_lib(testY, testX, model);
        acc = accuracy(1);
end