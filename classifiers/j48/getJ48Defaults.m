function a = getJ48Defaults
%% %%%%%%%%%%%%%%%%%%%%%%%%
%   Returns the default J48 arguments
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
    %parameters
    a.unpruned=0;
    a.confidence=0.25;
    a.number=2;
    a.reduced_error=0;
    a.folds=3;
    a.binary=0;
    a.laplace=0;
    a.raising=1;
    a.cleanup=1;
end