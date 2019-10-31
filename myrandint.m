function y = myrandint(MaxInt,m,n)
%function y = myrandint(MaxInt,m,n)
% This functions creates random numbers between [1 MaxInt] (1 itself and MaxInt itself)
if nargin == 1
    y = ceil(rand*MaxInt);
elseif nargin == 3
    y = ceil(rand(m,n)*MaxInt);
else
    warning('Incorrect Number of Inputs');
end

    