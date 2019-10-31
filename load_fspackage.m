curPath = pwd;

%% load weka jar, and common interfacing methods.
path(path, [curPath filesep 'lib']);
path(path, [curPath filesep 'lib' filesep 'weka']);
loadWeka(['lib' filesep 'weka']);

%% feature selection algorithms
path(path,[curPath filesep 'fs_sup_blogreg']);
path(path,[curPath filesep 'fs_sup_cfs']);
path(path,[curPath filesep 'fs_sup_chisquare']);
path(path,[curPath filesep 'fs_sup_fcbf']);
path(path,[curPath filesep 'fs_sup_fisher_score']);
path(path,[curPath filesep 'fs_sup_gini_index']);
path(path,[curPath filesep 'fs_sup_information_gain']);
path(path,[curPath filesep 'fs_sup_kruskalwallis']);
path(path,[curPath filesep 'fs_sup_mrmr']);
path(path,[curPath filesep 'fs_sup_relieff']);
path(path,[curPath filesep 'fs_sup_sbmlr']);
path(path,[curPath filesep 'fs_sup_ttest']);
path(path,[curPath filesep 'fs_uns_spec']);

%% predictors
path(path,[curPath filesep 'ME']);
path(path,[curPath filesep 'classifiers' filesep 'knn']);
path(path,[curPath filesep 'classifiers' filesep 'svm']);
path(path,[curPath filesep 'classifiers' filesep 'j48']);
path(path,[curPath filesep 'classifiers' filesep 'bayes']);
path(path,[curPath filesep 'clusters' filesep 'kmeans']);

%% Feature extraction
path(path,[curPath filesep 'feature_extraction']);
%% data preprocessors
path(path,[curPath filesep 'preprocessor']);

%% evaluator
path(path,[curPath filesep 'evaluator' filesep 'fsevaluator']);

%% ability to run experiments.
%path(path, [curPath filesep 'examples' filesep 'code' filesep ...
%    'result_statistic' filesep 'supervised' filesep]);
load(strcat(curPath,'\Dataset\dataset_BCIcomp1.mat'));
load (strcat(curPath,'\Dataset\labels_data_set_iii.mat'));
clear curPath;