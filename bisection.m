function [c] = bisection(F, a, b, tolerance)
    if (F(a)*F(b) >= 0)
        return
    end
    while (b - a > tolerance)
        c = (a + b) / 2;
        fprintf('%d, %d, %d\n', a, b, c);
        if (F(c) == 0)
            return
        end
        if (F(a)*F(b) < 0)
            b = c;
        else 
            a = c;
        end
    end
end
