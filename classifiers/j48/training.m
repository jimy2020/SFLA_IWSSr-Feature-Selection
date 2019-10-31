function [d,a] =  training(a,d)
  
  if a.algorithm.verbosity>0
    disp(['training ' get_name(a) '.... '])
  end
  
 
t = weka.classifiers.trees.J48();
  
%% handle options
tmp = wekaArgumentString({'-M',a.number});

if (a.reduced_error==0 && a.unpruned==0),
tmp=wekaArgumentString({'-C',a.confidence});
end

if (a.reduced_error==1),
    tmp=wekaArgumentString({'-N',a.folds},tmp);
    tmp=wekaArgumentString({'-R',''},tmp);
end

if (a.unpruned==1),
    tmp=wekaArgumentString({'-U',''},tmp);
end
if (a.binary==1),
    tmp=wekaArgumentString({'-B',''},tmp);
end
if (a.laplace==1),
    tmp=wekaArgumentString({'-A',''},tmp);
end
if (a.raising==0),
    tmp=wekaArgumentString({'-S',''},tmp);
end
if (a.cleanup==0),
    tmp=wekaArgumentString({'-L',''},tmp);
end

t.setOptions(tmp);

%% train classifier
t.buildClassifier(wekaCategoricalData(d));
  
% store
a.tree = t;
a.feats=wekaGetFeaturesFromGraph(a.tree);
if ~a.algorithm.do_not_evaluate_training_error
    d=test(a,d);
end


