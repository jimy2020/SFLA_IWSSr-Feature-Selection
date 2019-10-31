function Newfrog = GenerateInitialFrogs(NumOfFrog)
global var;

    Newfrog = cell(NumOfFrog,1);
    for i=1:NumOfFrog
        Newfrog{i,1} = randsampleWRW(1:var.NumOfFeature,var.f_max,var.Probsel);
    end
    
end



