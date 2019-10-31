 function Frog = updateFrog(FrogW,FrogB, var, X, Y,FISP)
%  var = variable();  
%  load X;
%  load Y;
%  load Frog_w Frog_w;
%  load Frog_b Frog_b;
%  load FISP FISP;
%     Frog = Frog_w
    Frog =FrogW
%     FrogB = Frog_b;
    fw = Frog.feacher;
    fb = FrogB.feacher;
    SR_b = size(FrogB.feacher, 2);         % number of feacher in feacher set of best frog
    SR_w = size(FrogW.feacher, 2);         % number of feacher in feacher set of worst frog
    if(SR_b > SR_w)
        S_b = min([fix(rand(1)*(SR_b - SR_w)) var.S_max]);
    else
        S_b = max([fix(rand(1)*(SR_b - SR_w)) -1*var.S_max]);
    end
% Decrease or increase the feachers of worst frog
   loc=[];
   for j=1:size(fw,2)
         for i=1:size(FISP,1) 
            if FISP(i,1) == fw(1,j)
              loc =[loc i];
              break;
            end   
         end
   end
    Frog=[];
    [s, index]=sort(loc)
    for ii=1:size(fw,2)
       ind =index(1,ii);
       F= fw(1,ind);
       Frog=[Frog F];
    end
 %************************************************
   locb=[];
   for j=1:size(fb,2)
         for i=1:size(FISP,1) 
            if FISP(i,1) == fb(1,j)
              locb =[locb i];
              break;
            end   
         end
   end
    bFrog=[];
    [s, index]=sort(locb)
    for ii=1:size(fb,2)
       ind =index(1,ii);
       F= fb(1,ind);
       bFrog=[bFrog F];
    end
%**************************************************
    if(S_b < 0)
        
       while (-1*S_b) > 0
           Frog = Frog(:,1:end-1);
           S_b = S_b + 1;
       end
    else
        c=0
       while S_b > 0
           c=c+1;
%            f=bFrog(1,c);
           f=FISP(c,1);
           Frog =[Frog f];
           S_b = S_b - 1;
       end 
        
    end
    Frog.feacher=Frog;
    % Crossover of randomly selected feacher from worst frog
%    Frog = crossoverRule(Frog, FrogB);
    % Mutation of randomly selected role from frog
%   Frog= mutationRule(Frog,X);  
 end