global var

var.f_max = 40;                 %maximmum number of feature in frog
var.sfla_p = 100;               %number of initial population
var.sfla_m = 10;                %number of memeplexs
var.sfla_n = var.sfla_p / var.sfla_m;                 %number of frog in each memeplex
var.sfla_q = 4;                 %number of frog in submemeplex
var.IT_max = 40;
var.IT_mem = 5;
var.minFitness = 70;            %minimum fitness of initial frog
var.S_max = 10;                 %maximmum leaping step size
var.CV =10;
var.NumOfFeature=numel(score);
var.Score=Score;
var.Probsel=Probsel;
