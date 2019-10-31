function [tsACC] = Bayes_CV_estimate(trainX,trainY,testX,testY,options)

%if they didn't specify an option,
%then we will go with the 'supervised' parameter.
if nargin<=4
    %options for the Bayes classifier
    options.D = 1; 
end

tsACC = bayes(options, trainX, trainY, testX, testY);
tsACC = tsACC.acc;