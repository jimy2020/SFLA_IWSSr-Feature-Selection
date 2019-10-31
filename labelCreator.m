Ttrain=zeros(2,140);
Ttest=zeros(2,140);
for i=1:140
    if(y_train(i,1) ==1)
        Ttrain(1,i)=1;
    else
        Ttrain(2,i)=1;
    end
    if(y_test(i,1) ==1)
        Ttest(1,i) =1 ;
    else
        Ttest(2,i) =1;
    end
end