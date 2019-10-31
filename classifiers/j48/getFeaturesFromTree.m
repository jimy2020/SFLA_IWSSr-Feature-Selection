function Feats=getFeaturesFromTree(a)
% this function retrieves the used features from a weka tree "Drawable"
% object
if(~isempty(strfind(class(a),'weka.classifiers.trees')))
    s=char(a.graph);
else
    s=char(a);  
end

I=strfind(s,'inp');
Feats=zeros(1,size(I,2));
offset = 1;

for i=I
    f=sscanf(s(i+3:end),'%d');
    Feats(offset) = f;
    offset = offset + 1;
end

Feats=unique(Feats);