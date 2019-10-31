function fit = evalut(newF)
global var;
   fit = Func(newF); 
   
end

function AvgAcc = Func(Set)
    global Data1
    global bayesOptions
    S = Set(1,1);
    BestAcc = zeros(1,2);
    acc = zeros(1,2);
    k = 1;
    CVO = cvpartition(Data1.out,'k',2);
   
        for fold=1:2
            trIdx = CVO.training(fold);
            teIdx = CVO.test(fold);
            pred = classify(Data1.in(teIdx,S),Data1.in(trIdx,S),Data1.out(trIdx,:),'diaglinear');
            acc(fold) = sum(pred==Data1.out(teIdx))/numel(pred);
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
            CVO = cvpartition(Data1.out,'k',2);
            for fold=1:2
                trIdx = CVO.training(fold);
                teIdx = CVO.test(fold);
                pred = classify(Data1.in(teIdx,SS),Data1.in(trIdx,SS),Data1.out(trIdx,:),'diaglinear');
                acc(fold) = sum(pred==Data1.out(teIdx))/numel(pred);
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
               for fold=1:2
                trIdx = CVO.training(fold);
                teIdx = CVO.test(fold);
                pred = classify(Data1.in(teIdx,SS),Data1.in(trIdx,SS),Data1.out(trIdx,:),'diaglinear');
                acc(fold) = sum(pred==Data1.out(teIdx))/numel(pred);
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
      Acc = zeros(1,2);
    for i=1:5
        v = 1;
        while v>.01
            CVO = cvpartition(Data1.out,'k',2);
            for fold=1:2
                trIdx = CVO.training(fold);
                teIdx = CVO.test(fold);
                pred = classify(Data1.in(teIdx,S),Data1.in(trIdx,S),Data1.out(trIdx,:),'diaglinear');
                acc(fold) = sum(pred==Data1.out(teIdx))/numel(pred);
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
   AvgAcc = mean(Acc);
      
    end
        
    