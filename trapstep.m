function w = trapstep(t, y, h)
    %one step of the Trapezoid Method
    z1 = ydot(t, y);
    g = y + h * z1;
    z2 = ydot(t + h, g);
    w = y + h * (z1 + z2) / 2;
end
