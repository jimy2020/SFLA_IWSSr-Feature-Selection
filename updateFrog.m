function Frog = updateFrog(FrogW,FrogB, var, X, Y)
global Data1
global var
%  var = variable();
%  load X;
%  load Y;
%  load Frog_w Frog_w;
%  load Frog_b Frog_b;
%  load FISP FISP;
%     Frog = Frog_w
Frog =FrogW;
%     FrogB = Frog_b;
fw = Frog{1,1}.feacher;
fb = FrogB{1,1}.feacher;
SR_b = size(FrogB{1,1}.feacher, 2);         % number of feacher in feacher set of best frog
SR_w = size(FrogW{1,1}.feacher, 2);         % number of feacher in feacher set of worst frog
if(SR_b > SR_w)
    S_b = min([fix(rand(1)*(SR_b - SR_w)) var.S_max]);
else
    S_b = max([fix(rand(1)*(SR_b - SR_w)) -1*var.S_max]);
end
% Decrease or increase the feachers of worst frog

Xfw=[];
Xfb=[];
for i=1:size(fw,2)
    index = fw(1,i);
    for j=1: size(X,2)
        if j==index
            Xnew = X(:,j);
            Xfw =[Xfw Xnew];
        end
    end
end
for i=1:size(fb,2)
    index = fb(1,i);
    for j=1: size(X,2)
        if j==index
            Xnew = X(:,j);
            Xfb =[Xfb Xnew];
        end
    end
end
% [score1] =  SU(Xfb,Y);
% score1(score1==0) = 10.^(-10);
% probSe1 = score1./sum(score1);
 [~,IX1] = sort(var.Score(fb),'descend');
 fb = fb(IX1);
%%
% Xfw1=[Xfw Xfb]
% [score2] =  SU(Xfw1,Y);
% score2(score2==0) = 10.^(-10);
% s=sum(score2);
% probSe2 = score2./sum(score2);
[~,IX] = sort(var.Score(fw),'descend');
 fw = fw(IX);
 Frog{1,1}.feacher=fw;
%%
% loc=[];
% for j=1:size(fw,2)
%     for i=1:size(FISP,1)
%         if FISP(i,1) == fw(1,j)
%             loc =[loc i];
%             break;
%         end
%     end
% end
% Frog=[];
% [s, index]=sort(loc)
% for ii=1:size(fw,2)
%     ind =index(1,ii);
%     F= fw(1,ind);
%     Frog=[Frog F];
% end
% %************************************************
% locb=[];
% for j=1:size(fb,2)
%     for i=1:size(FISP,1)
%         if FISP(i,1) == fb(1,j)
%             locb =[locb i];
%             break;
%         end
%     end
% end
% bFrog=[];
% [s, index]=sort(locb)
% for ii=1:size(fb,2)
%     ind =index(1,ii);
%     F= fb(1,ind);
%     bFrog=[bFrog F];
% end
%**************************************************

if(S_b < 0)
    
    while (-1*S_b) > 0
        Frog{1,1}.feacher = Frog{1,1}.feacher(1:end-1);
        S_b = S_b + 1;
    end
else
    c=0;
    while S_b > 0
        c=c+1;
        f=fb(1,c);
        Frog{1,1}.feacher(end+1)=f;
        S_b = S_b - 1;
    end
    
end
% Frog.feacher=Frog;
% Crossover of randomly selected feacher from worst frog
%    Frog = crossoverRule(Frog, FrogB);
% Mutation of randomly selected role from frog
%   Frog= mutationRule(Frog,X);
end