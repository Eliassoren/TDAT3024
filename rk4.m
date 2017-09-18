function w  = rk4(func,y0,a,b,n)
% Step Runge-kutta of fourth order

% Input
%   func: the right side function of ODE
%   y0: inital condition of ODE
%   a: start of interval
%   b: end of interval
%   n: number of sub intervals
    w(:,1) = y0; % Numerical y values
    t = a; % t values iterated for each step
    h = (b-a)/n; % h: iteration step length
    
    for i=1:n-1
        s1 = feval(func, t, w(:,i));
        s2 = feval(func, t+h/2, w(:,i)+(h/2)*s1);
        s3 = feval(func, t+h/2, w(:,i)+(h/2)*s2);
        s4 = feval(func, t+h, w(:,i)+h*s3);
        w(:,i+1) = w(:,i) + (h/6)*(s1 + 2*s2 + 2*s3 + s4);
        t = t+h;
    end

end

