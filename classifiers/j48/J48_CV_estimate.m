function [tsACC] = J48_CV_estimate(trainX,trainY,testX,testY,options)

tsACC = j48(options, trainX, trainY, testX, testY);
tsACC = tsACC.tree_accuracy;