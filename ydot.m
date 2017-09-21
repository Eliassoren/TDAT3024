% System med lineære diffliginger 
% Input
    % t: tidsvariabel i ODE
    % system: system med y, y', theta, theta'
    % W: vindhastighet
function ydot = ydot(t, system, W)
    l = 6; % Lengde fra midten av brua
    a = 0.2; % Hookes koeffisient for ulinearitet
    d = 0.01; % Dempingskoeffisient
    omega = 2 * pi * 38 / 60; % Vinkel på brua
    K = 1000; % Fjærkonstant i Hookes lov, 1000N
    m = 2500; % Massen til en fot med vei, 2500kg
    y = system(1);
    yDerivert = system(2);
    theta = system(3);
    thetaDerivert = system(4);
 % Eksponentledd med eulers tall
    e1 = exp(a * (y - l * sin(theta))); % e^(a * (y(1) - 0.5*len * sin(y(3))))
    e2 = exp(a * (y + l * sin(theta))); % e^(a * (y(1) + 0.5*len * sin(y(3))))
    
 % Systemet med ligninger
    yDobbelDerivert = (-d * yDerivert - (K/m) * (e1 + e2 - 2) / a); % y'' 
    yDobbelDerivert = yDobbelDerivert + 0.2 * W * sin(omega * t); % Legg til vind i y-ligningen for å legge til svingning på brua
    thetaDobbelDerivert = -d * thetaDerivert + ( (3 * cos(theta)/l )* (K/m) * (e1 - e2) / ( a)); % theta''
    
    ydot = [yDerivert yDobbelDerivert thetaDerivert thetaDobbelDerivert]; % Output
end
