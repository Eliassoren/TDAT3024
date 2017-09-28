function w = trapstep(t, y, h, W, omega)
    %one step of the Trapezoid Method
    z1 = ydot(t, y, W, omega);
    g = y + h * z1;
    z2 = ydot(t + h, g, W, omega);
    w = y + h * (z1 + z2) / 2;
end
