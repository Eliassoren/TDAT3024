% System med lineære diffliginger 
% Input
    % t: tidsvariabel i ODE
    % y: høyreside funksjon i ODE
    % W: vindhastighet
function ydot = ydot(t, y, W)
    l = 12; % Bredde på brua
    a = 0.2; % Hookes koeffisient for ulinearitet
    d = 0.01; % Dempingskoeffisient
    omega = 2 * pi * 38 / 60; % Vinkel på brua
    
 % Eksponentledd
    e1 = exp(a * (y(1) - 0.5*l * sin(y(3)))); % e^a * (y(1) - 0.5*len * sin(y(3)))
    e2 = exp(a * (y(1) + 0.5*l * sin(y(3)))); % e^a * (y(1) + 0.5*len * sin(y(3)))
    
 % Systemet med ligninger
     % y'
    ydot(1) = y(2);
    % y''
    ydot(2) = -d * y(2) - 0.4 * (e1 + e2 - 2) / a + 0.2 * W * sin(omega * t);
    % ?'
    ydot(3) = y(4);
    % ?''
    ydot(4) = -d * y(4) + 1.2 * cos(y(3)) * (e1 - e2) / (0.5*l * a);
end
