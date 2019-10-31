function [ID] = buildIDX(X, Y, per, iter)
%[X Y] = buildIDX(X, Y, percent), resample per percent instances from each class.
% X - the return data, each row is an instance
% Y - the input label in format 1 2 3 ...
% per - the percent of instances we want to sample if per > 1, sample per
% instances
% iter - how many iterations we want to sample 

numCL = max(Y);
if numCL == 1
    Y(Y==-1) = 2; numCL = 2;
end

ID = -ones(size(X,1),iter);

if per < 1 && per > 0
    for it = 1:iter
        for i =1:numCL
            idx = find(Y == i);
            temp = length(idx);
            nS = floor(temp*per);
            randIDX = randperm(temp);
            ID(idx(randIDX(1:nS)),it) = 1;
        end
    end
elseif per > 1
    for it = 1:iter
        for i =1:numCL
            idx = find(Y == i);
            temp = length(idx);
            nS = min(temp,per);
            randIDX = randperm(temp);
            ID(idx(randIDX(1:nS)),it) = 1;
        end
    end
end