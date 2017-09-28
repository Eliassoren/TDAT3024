function [c] = bisection(F, a, b, tolerance)
    if (F(a)*F(b) >= 0)
        c = 9;
        return
    end
    while (b - a > tolerance)
        c = (a + b) / 2;
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
