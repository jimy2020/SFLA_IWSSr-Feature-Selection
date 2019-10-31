function out1 = convert(out)
    a=unique(out);
    out1=zeros(length(out),1);
    for i=1:length(out)
        for j=1:length(a)
            if(out(i)==a(j))
           %if(strcmp(out(i),a(j)))
               out1(i,1)=j;
               break;
           end
        end
    end
end 