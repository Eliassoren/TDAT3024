% Trapesmetoden fra boka. 
% Brukes som den ble skrevet
function w = trapstep(t, y, h, W, omega, d)
    %one step of the Trapezoid Method
    z1 = ydot(t, y, W, omega, d);
    g = y + h * z1;
    z2 = ydot(t + h, g, W, omega, d);
    w = y + h * (z1 + z2) / 2;
end
