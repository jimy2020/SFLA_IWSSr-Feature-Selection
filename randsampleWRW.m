function v=randsampleWRW(x,k,w)
% same than randsample but Without Replacement and with Weighting

% Returns V, a weigthed sample of K elements taken among X without replacement
% X a vector of numerics
% K amount of element to sample from x
% W a vector of positive weights w, whose length is length(x)

% EXAMPLE:
% for i=1:100
%     v(i)=randsampleWRW([0,0.5,3,20],1,[0.5,0.4,0.05,0.05]);
% end
% plot(v,'o')

% Was initialy made by ROY, i just correct some details and add help
% see the link:
% http://www.mathworks.com/matlabcentral/newsreader/view_thread/141124
% Jean-Luc Dellis, april 2010

if k>length(x), error('k must be smaller than length(x)'), end
if ~isequal(length(x),length(w)),error('the weight W must have the length of X'),end
v=zeros(1,k);
for i=1:k
    v(i)=randsample(x,1,true,w);
    w(x==v(i))=0;
end
end