function w  = rk4(func,y0,a,b,n)
% RKF54

% Input
%   func: the right side function of ODE
%   y0: inital condition of ODE
%   a: start of interval
%   b: end of interval
%   n: number of sub intervals
    w(:,1) = y0; % Numerical y values
    t = a; % t values iterated for each step
    
    for i=1:n-1
        w(:,i+1) = RungaKuttaFehlbergStep54(func, w(:, i), h);
        t = t+h;
    end

end