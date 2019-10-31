function [BestSolution, BestCost] = SFLA(score,probsel,X,Y)
warning off
%% Problem Defination
%%CostFunction=@Sphere;
tic;
Probsel=probsel;
Score=score;

%% SFLA Parameters
variable;

%% Initialization
Initialfrogs = GenerateInitialFrogs(var.sfla_p);
Initialfrogs=ImproweFrog_WithIwssr(Initialfrogs);
% Initialfrogs = ImproweFrog_WithIwssrOneMimplex(Initialfrogs);
%InitialCountries1 = IWSS(InitialCountries);
for it=1:var.IT_max
rp = randperm(var.sfla_p);
memClass = fix(rp/(var.sfla_p+1)*var.sfla_m)+1;     %Generate random memplex for each frog

%% CREATE FROG PROBABILITY FOR SELECTION IN SUBMEMPLEX  
for j = 1:var.sfla_n
    pj = ((2*(var.sfla_n + 1 - j))/(var.sfla_n * (var.sfla_n + 1))) * 100;
    if (j == 1)
        memeplex.pj(j) = fix(pj);
    else
        memeplex.pj(j) = memeplex.pj(j-1) + fix(pj);
    end
end

for i = 1:var.sfla_m
    
    %Create memeplexes and sort related frog of memeplex
   for m=1:size(Initialfrogs,1)
   Frog{m}.feacher = Initialfrogs(m).SelVar;
   Fitness(m)= Initialfrogs(m).AvgAcc;
   end
   memeplex.Frogs{i} = Frog(memClass == i);
   memeplex.fit{i} = Fitness(memClass == i);
%     [C, I] = sort(memeplex.fit{i});
%     memeplex.Frogs{i} = memeplex.Frogs{i}(I);
%     memeplex.fit{i} = C;
    
    for j = 1:var.IT_mem
        
         disp(['Iteration:  ' num2str(it) '; memeplex:  ' num2str(i) '; IT_meme:  ' num2str(j)]);
         [C, I] = sort(memeplex.fit{i});
         memeplex.Frogs{i} = memeplex.Frogs{i}(I);
         memeplex.fit{i} = C;
        %create submemeplex and get worst best forgs.
        sub = subMemeplex(var.sfla_n, var.sfla_q, memeplex.pj);
        Frog_w = memeplex.Frogs{i}(min(sub));                   % Worst frog in submemeplex
        Fit_w = memeplex.fit{i}(min(sub));
        Frog_b = memeplex.Frogs{i}(var.sfla_n);                 % Best frog in memeplex
        Fit_b = memeplex.fit{i}(var.sfla_n);
        [C I] = sort(Fitness);
        Frog_g = Frog(I(var.sfla_p));                          % Best frog in whole population
        Fit_g = C(var.sfla_p);
        FrogNew = updateFrog(Frog_w, Frog_b, var, X, Y);
        newF =FrogNew{1,1}.feacher;
        fitNew = evalut(newF);
        if(fitNew > Fit_w)
            memeplex.Frogs{i}(min(sub)) = FrogNew;
            memeplex.fit{i}(min(sub)) = fitNew;
        else
            FrogNew = updateFrog(Frog_w, Frog_g, var, X, Y);
             newF =FrogNew{1,1}.feacher;
             fitNew = evalut(newF);
            if(fitNew> Fit_w)
                memeplex.Frogs{i}(min(sub)) = FrogNew;
                memeplex.fit{i}(min(sub)) = fitNew;
            else
                FrogNew = GenerateInitialFrogs(1);
                FrogNew = ImproweFrog_WithIwssr(FrogNew);
                fitNew =FrogNew.AvgAcc;
%                 fitNew = evalut(X, Y,newF,class);
                if(fitNew > Fit_w)
                    memeplex.fit{i}(min(sub))=fitNew;
                    Frog_n{1}.feacher = Initialfrogs(1).SelVar;
                    memeplex.Frogs{i}(min(sub)) = Frog_n;
                end
            end
        end
       memeplex.fit{i}(min(sub));
    end
end
s = 0;
 Tfit= [];
        for i = 1:var.sfla_m
            for j = 1:var.sfla_n
                s = s+1;
                fit1(s) = memeplex.fit{1,i}(1,j);
%                 AllFrog{1,s}.fech= memeplex.Frogs{1,i}(1,j).feacher;
%                 Tfit =[Tfit fit1];
            end
        end
          [maxFitness(it),index(it)] = max(fit1);
           BestCost=max(maxFitness);
end
BestSolution=BestCost;