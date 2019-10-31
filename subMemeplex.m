function sub = subMemeplex(sfla_n, sfla_q, pj)
    sub = zeros(1, sfla_q);
    r = randi(pj(sfla_n));
    
    for i = 1:sfla_n
        if(pj(i) > r)
            break;
        end
    end
    for x = 1:sfla_q
        sub(x) = i;
        while(sum(sub == i) > 0)
            r = randi(pj(sfla_n));
            for i = 1:sfla_n
                if(pj(i) > r)
                    break;
                end
            end
        end
    end
end