function a = j48(args, trainX, trainY, testX, testY)
% Generates a J48 wrapper on the WEKA J48 implementation with given
% parameters.
%
%   'args' parameters (with defaults):
%    unpruned=0      -- set to 1 to use unpruned trees
%    confidence=0.25 -- confidence threshold for pruning
%    number=2        -- minimum number of instances per leaf
%    reduced_error=0 -- set to 1 to use reduced error pruning
%    folds=3         -- number of folds for reduced error pruning
%    binary=0        -- set to 1 to use binary split for nominal attributes
%    laplace=0       -- set to 1 if laplace smoothing technique is used for
%                   predicted probabilities
%    raising=1       -- set to 0 if subtree raising should not be performed
%    cleanup=1       -- set to 0 if no cleaning up after the tree has been
%                   built.
%
%    Note: If you wish to use all of the defaults, you may just pass in a
%    non-struct parameter for 'args'. This will cause all of the default
%    parameters to be used.
%
%    trainX, trainY:
%    The X and Y values you wish to use to train the tree.
%
%    testX, testY:
%    The X and Y values you wish to use to test the tree's accuracy.
%
%    Output:
%    The output will be the same struct you passed in for 'a', but with the
%    tree, the vital features, and accuracy appended as fields. They will  
%    be named 'classifier', 'features', and 'tree_accuracy', respectively.

%% This is the default setup for the J48 tree, what the user will get if
%% they do not pass in their own.
if(~isstruct(args))
    a = getJ48Defaults();
else
    a = args;
end

%% Create the Java object of type J48 tree.
t = weka.classifiers.trees.J48();

%% Set the options to those of the user-submitted struct, or the default
tmp = '';

if(isfield(a,'unpruned') && a.unpruned)
    tmp = wekaArgumentString({'-U',''},tmp);
end

if(isfield(a,'confidence'))
    tmp = wekaArgumentString({'-C',a.confidence},tmp);
end

if(isfield(a,'number'))
    tmp = wekaArgumentString({'-M',a.number},tmp);
end

if(isfield(a,'reduced_error') && a.reduced_error)
    tmp = wekaArgumentString({'-R',''},tmp);
    
    %using num folds doesn't make sense unless reduced error is selected.
    if(isfield(a,'folds'))
        tmp = wekaArgumentString({'-N',a.folds},tmp);
    end
end

if(isfield(a,'binary') && a.binary)
    tmp = wekaArgumentString({'-B',''},tmp);
end

if(isfield(a,'raising') && a.raising)
    tmp = wekaArgumentString({'-S',''},tmp);
end

if(isfield(a,'cleaned') && a.cleaned)
    tmp = wekaArgumentString({'-L',''},tmp);
end

t.setOptions(tmp);

%% Train the dataset.
t.buildClassifier(wekaCategoricalData(trainX, SY2MY(trainY)));
clear cat;

%% Store the classifier in the struct for use by the user.
a.classifier = t;

%% Find the important features, and add them to the user's struct.
a.features = getFeaturesFromTree(t);

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

%Add the accuracy to the return struct.
a.tree_accuracy = acc;
