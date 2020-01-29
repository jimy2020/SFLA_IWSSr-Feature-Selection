clear all
clc;
load_fspackage;
load d.mat;
load CNS;
labelCreator;
%[train,test] = s_extraction(x_train,x_test);
% Data.in: training samples (rows are data samples and colomns are features).
% Data.out: class lables
train=data(:,2:end);
y_train=data(:,1);
global Data1;

Data1.in = [train];
% Data1.test = [test];

Data1.out = y_train;
% Data1.Ttest=y_test;
CVO = cvpartition(40,'kfold',10);
Data1.CVO=CVO;
save('Data1.mat', '-struct', 'Data1');
load ('Data1.mat');

[Data1.in, meanX, nor] = normData(Data1.in, 1, 1);
Data1.out=convert(Data1.out);
[score] =  SU(Data1.in,Data1.out);
%[ind,score] =  relieff(Data1.in,Data1.out,10);
score(score==0) = 10.^(-10);
s=sum(score);
probSel = score./sum(score);
[~, BestCost] = SFLA(score,probSel,Data1.in,Data1.out);
