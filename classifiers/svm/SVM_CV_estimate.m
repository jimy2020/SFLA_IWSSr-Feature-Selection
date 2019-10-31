function [tsACC, cv_acc, tspY, Opt_sigma, Opt_c, model] = SVM_CV_estimate(trainX,trainY,testX,testY,grid)

%-----------------------------------------
%K-fold Cross-validation on training set;
%-----------------------------------------
if length(unique(trainY))==2
    trainY(trainY==2) = -1;
    testY(testY==2) = -1;
end

if nargin<=4
    % Cross-validation setting for the SVM classifier
    grid.Linear_flag = 1;     % 1: train linear SVM, 0: nonlinear SVM;
    grid.FOLD_NUM    = 5;     % k-fold CV;
    grid.MAX_C       = +10;   % Tuning C only;
    grid.MIN_C       = -5;    % C = exp(C);
    grid.MAX_SIGMA   = 0;     % No sigma tuning;
    grid.MIN_SIGMA   = 0;
    grid.SIGMA_TIMES = 1;
    grid.C_TIMES     = 16;
end

cv_acc = zeros(grid.C_TIMES,grid.SIGMA_TIMES);

for c_count=1:grid.C_TIMES
    
    if(grid.C_TIMES==1)
        c_val=grid.MIN_C;
    else
        c_val=grid.MIN_C+1.0*(grid.MAX_C-grid.MIN_C)*(c_count-1)/(grid.C_TIMES-1);
    end

    for sigma_count=1:grid.SIGMA_TIMES
        
        %[c_count sigma_count]
        
        if(grid.SIGMA_TIMES==1)
            sigma=grid.MIN_SIGMA;
        else
            sigma=grid.MIN_SIGMA+1.0*(grid.MAX_SIGMA-grid.MIN_SIGMA)*(sigma_count-1)/(grid.SIGMA_TIMES-1);
        end
        
        gamma=1.0/(2.0*exp(2.0 * sigma));
        
        % Do k-fold cross-validation;
        if(grid.Linear_flag == 1)
            Param_Str=['-t 0 -c ',num2str(exp(c_val)), ' -v ' num2str(grid.FOLD_NUM)];
        else
            Param_Str=['-g ',num2str(gamma),' -c ',num2str(exp(c_val)), ' -v ' num2str(grid.FOLD_NUM)];
        end
        
        cv_acc(c_count,sigma_count) = svmtrain_lib(trainY,trainX,Param_Str);
        
    end % for sigma_count=1:grid.SIGMA_TIMES
    
end %for c_count=1:grid.C_TIMES

max_cv_acc = max(max(cv_acc));
acc_index = [];
for i=1:size(cv_acc,1)
    for j=1:size(cv_acc,2)
        if(cv_acc(i,j)==max_cv_acc)
            acc_index = [acc_index; [i j]];
        end
    end
end
med_index = median(acc_index,1);
diff = sum((acc_index - repmat(med_index,size(acc_index,1),1)).^2,2);
[Y,I] = min(diff);
opt_index = acc_index(I,:);
opt_c_index = opt_index(1,1); opt_sigma_index = opt_index(1,2);

if(grid.SIGMA_TIMES==1)
    Opt_sigma=grid.MIN_SIGMA;
else
    Opt_sigma=grid.MIN_SIGMA+1.0*(grid.MAX_SIGMA-grid.MIN_SIGMA)*(opt_sigma_index-1)/(grid.SIGMA_TIMES-1);
end

if(grid.C_TIMES==1)
    Opt_c=grid.MIN_C;
else
    Opt_c = grid.MIN_C+1.0*(grid.MAX_C-grid.MIN_C)*(opt_c_index-1)/(grid.C_TIMES-1);
end

fprintf('The max ACC: %.3f is achieved at-> c: %f, gamma: %f\n', max_cv_acc, exp(Opt_c), 1.0/(2.0*exp(2.0 * Opt_sigma)));

if ~isempty(testX)
    %---------------------------------------------------------
    % Test on the test data set with the optimal sigma and C;
    %---------------------------------------------------------
    if(grid.Linear_flag == 1)
        Param_Str=['-t 0 -c ', num2str(exp(Opt_c)),' -b 0'];
    else
        Opt_gamma=1.0/(2.0*exp(2.0 * Opt_sigma));
        Param_Str=['-g ', num2str(Opt_gamma),' -c ', num2str(exp(Opt_c)),' -b 0'];
        % -b 0: do not use probabilistic output;
    end
    
    model=svmtrain_lib(trainY, trainX, Param_Str);
    [tspY,tsACC]=svmpredict_lib(testY, testX, model);
    
    tsACC = tsACC(1)/100;
else
    tsACC = [];
    tspY = [];
    model = [];
end