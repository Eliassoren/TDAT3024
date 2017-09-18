function w = trapstep(t, y, h, W)
    %one step of the Trapezoid Method
    z1 = ydot(t, y, W);
    g = y + h * z1;
    z2 = ydot(t + h, g, W);
    w = y + h * (z1 + z2) / 2;
end
