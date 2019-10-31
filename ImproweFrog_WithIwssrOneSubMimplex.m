function SubMimplex = ImproweFrog_WithIwssrOneSubMimplex(Sub)
    global var;
    SubMimplex = struct('SelVar',{},'AvgAcc',{},'MembershipDegree',{});
    Set(1,:)=Sub.feature;
   
        [~,IX] = sort(ICA_Prams.Score(Sub.feature),'descend');
        Set = Set(IX);
        SubMimplex = Func(Set);
        SubMimplex.MembershipDegree=Sub.MembershipDegree;
        % fprintf('%f    ', SubMimplex.AvgAcc );
       %  fprintf('%f  \n  ', SubMimplex.AvgAcc );
    clear Set
 end

function Sol = Func(Set)
    global Data
    global bayesOptions
    S = Set(1,1);
    BestAcc = zeros(1,5);
    acc = zeros(1,5);
    k = 1;
    CVO = cvpartition(Data.out,'k',5);
   
        for fold=1:5
            trIdx = CVO.training(fold);
            teIdx = CVO.test(fold);
            pred = classify(Data.in(teIdx,S),Data.in(trIdx,S),Data.out(trIdx,:),'diaglinear');
            acc(fold) = sum(pred==Data.out(teIdx))/numel(pred);
        end

      %  if k<=1
            BestData = S;
            BestAcc = acc;
    %    else
      %      if mean(acc)>mean(BestAcc)&&sum(acc>BestAcc)>=2
       %         BestData = S;
       %         BestAcc = acc;
       %     end
      %  end
      for k=2:numel(Set)
        BestOp=[];
        for j= 1 : length(S)
            SS=S;
            SS(j)=Set(k);
            CVO = cvpartition(Data.out,'k',5);
            for fold=1:5
                trIdx = CVO.training(fold);
                teIdx = CVO.test(fold);
                pred = classify(Data.in(teIdx,SS),Data.in(trIdx,SS),Data.out(trIdx,:),'diaglinear');
                acc(fold) = sum(pred==Data.out(teIdx))/numel(pred);
            end
             if mean(acc)>mean(BestAcc)&&sum(acc>BestAcc)>=2
                BestData = SS;
                BestAcc = acc;
                BestOp=[j k];
            end
        end
            SS=S;
           % SS = cat(2,S,Set(k));
            SS=[S Set(k)];
               for fold=1:5
                trIdx = CVO.training(fold);
                teIdx = CVO.test(fold);
                pred = classify(Data.in(teIdx,SS),Data.in(trIdx,SS),Data.out(trIdx,:),'diaglinear');
                acc(fold) = sum(pred==Data.out(teIdx))/numel(pred);
               end
                 if mean(acc)>mean(BestAcc)&&sum(acc>BestAcc)>=2
                    BestData = SS;
                    BestAcc = acc;
                    BestOp=Set(k);
                 end
                 if  ~isempty(BestOp)
                    if length(BestOp)== 1
                        S=[S Set(k)];
                      %  S = cat(2,S,Set(k));
                    else if length(BestOp)== 2
                            S(BestOp(1))=Set(BestOp(2));
                          end
                    end
                 end
              
            
    end
      Acc = zeros(1,5);
    for i=1:5
        v = 1;
        while v>.01
            CVO = cvpartition(Data.out,'k',5);
            for fold=1:5
                trIdx = CVO.training(fold);
                teIdx = CVO.test(fold);
                pred = classify(Data.in(teIdx,S),Data.in(trIdx,S),Data.out(trIdx,:),'diaglinear');
                acc(fold) = sum(pred==Data.out(teIdx))/numel(pred);
%               a = bayes(bayesOptions, Data.in(trIdx,S), Data.out(trIdx,:), Data.in(teIdx,S), Data.out(teIdx));
%               acc(fold) = a.acc;
            end
            v = var(acc);
        end
        Acc(i) = mean(acc);
    end
    %%
   %  disp('iwssr');
   % disp(length(S));
  %  disp(mean(Acc));
    %%
    Sol.SelVar = S;
    Sol.AvgAcc = mean(Acc);
      
    end
        