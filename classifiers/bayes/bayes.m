function a = bayes(a, trainX, trainY, testX, testY)
%% ===========================================================================
%  Naive Bayes Decision Tree  [WEKA Required]
%  ===========================================================================
%  a0=bayes(a, trainX, trainY, testX, testY)
%
%  Parameters:
%  a:
%  'a' is a struct that has field 'D', and/or 'K', with the field you would
%  like the classifier to use set to true. If you would like to use
%  neither, that is fine as well, but you may use a maximum of 1. It is ok
%  if both fields are present in your struct, so long as only one of them
%  is set to true.
%  D means that you wish to incorporate supervised discretion when
%  you are processing numeric attributes.
%  K means that you wish to use kernel estimation for modeling numeric
%  attributes rather than a single normal distribution.
%
%  trainX, trainY:
%  The X and Y values you wish to use to train the tree.
%
%  testX, testY:
%  The X and Y values you wish to use to test the tree's accuracy.
%
%  Output:
%  The output will be the same struct you passed in for 'a', but with the
%  tree, and accuracy appended as fields. They will be named 'classifier',
%  and 'tree_accuracy', respectively.

%% Ensure that param is legitimate.
param = '';
numtrue = 0;
if(isfield(a,'K') && a.K)
    param = '-K';
    numtrue = numtrue + 1;
end
if(isfield(a,'D') && a.D)
    param = '-D';
    numtrue = numtrue + 1;
end

if(numtrue > 1)
    error(['You may only have -D OR -K as parameters, not both. Neither is fine as well. ' ...
        'Please remove at least one parameter by either removing it from the struct or setting to false, then try again.']);
end

%% Create the Java object of type Naive Bayes Classifier.
t = weka.classifiers.bayes.NaiveBayes();

%% Set the options to those of the user-submitted struct, or the default
tmp = wekaArgumentString({param,''});
t.setOptions(tmp);

%% Train the dataset.
cat = wekaCategoricalData(trainX, SY2MY(trainY));
t.buildClassifier(cat);
clear cat;

%% Store the classifier in the struct for use by the user.
a.classifier = t;

%% Calculate the Classification Accuracy
dw = wekaCategoricalData(testX,SY2MY(testY));

%Yest is the actual results from the tree.
Yest = zeros(dw.numInstances(),1);

%loop through, and see what the output is for each instance
for i=1:dw.numInstances()
    Yest(i) = t.classifyInstance(dw.instance(i-1))+1;
end

%Accuracy = (Number of correct classifications)/(Number of classifications)
acc = sum(Yest == testY)/length(Yest);

%% Add the accuracy to the return struct.
a.acc = acc;