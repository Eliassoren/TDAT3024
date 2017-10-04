% System med lineære differensialliginger 
% Input
    % t: tidsvariabel i ODE
    % system: system med y, y', theta, theta'
    % W: vindhastighet
    % omega: svingningskoeffisient
    % d: dempningskoeffisient
function ydot = ydot(t, system, W, omega, d)
    l = 6; % Lengde fra midten av brua og til kanten. Radius i svingningene.
    a = 0.2; % Hookes koeffisient for ulinearitet
    K = 1000; % Fjærkonstant i Hookes lov, 1000N
    m = 2500; % Massen til en fot med vei, 2500kg
    
 % Systemets verdier hentes ut
    y = system(1);
    yDerivert = system(2);
    theta = system(3);
    thetaDerivert = system(4);
    
 % Eksponentledd med eulers tall
    e1 = exp(a * (y - l * sin(theta))); % e^(a * (y - l * sin(y(3))))
    e2 = exp(a * (y + l * sin(theta))); % e^(a * (y + l * sin(y(3))))
    
 % Definerer systemet med andreordens ligninger
    yDobbelDerivert = (-d * yDerivert - K/(m*a) * (e1 + e2 - 2)); % y'' 
    thetaDobbelDerivert = -d * thetaDerivert + ( (3 * cos(theta)/l )* K/(m*a) * (e1 - e2) ); % theta''
 
 % Legger til vind i y-ligningen for å framprovosere svingning på brua       
    yDobbelDerivert = yDobbelDerivert + 0.2 * W * sin(omega * t); 

 % Sender ut en rekursiv output der leddet med funksjon får derivert,
 % leddene med derivert får dobbelderivert. Derumed er systemet uttrykt
 % lineært
    ydot = [yDerivert yDobbelDerivert thetaDerivert thetaDobbelDerivert]; % Output
end
