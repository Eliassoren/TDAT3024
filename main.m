% ([intervall],initialverdier[y y' theta theta'],antall steg,steg per plotpoint, toleranse, vindhastighet km/h, boolean kjor grafing eller computing)

% Standard omega-verdi
normalOmega = 2 * pi * 38 / 60;

runGraph = true; % Sett til true for å rendre grafer
exercise = 7; % Hvilken oppgave som skal kjøres

switch (exercise)
    % Exercise 1 TODO: Use tacoma with trapstep instead of Fehlberg
    case 1
        tacoma([0 500], [0 0 0.001 0], 0.04, 5, 1* 10^-6, 58.99, normalOmega, runGraph);
    
    % Exercise 2
    case 2
        tacoma([0 500], [0 0 0.001 0], 0.04, 5, 1* 10^-6, 58.99, normalOmega, runGraph);
        
    % Exercise 3
    case 3
        windspeed = 55;  % starting windspeed
        angularMagnificationTheta1 = 100 + tacoma([0 500], [0 0 0.001 0], 0.04 ,5, 0.0000001, windspeed, false)
        angularMagnificationTheta2 = 100 + tacoma([0 500], [0 0 0.0001 0], 0.04 ,5, 0.0000001, windspeed, false)
        angularMagnificationTheta3 = 100 + tacoma([0 500], [0 0 0.00001 0], 0.04 ,5, 0.0000001, windspeed, false)
        % Is the angle magnification approx consistent. YES
        
    % Exercise 4 (finding minimum windspeed inwhich a angular
    % magnification of 100 or more occurs
    case 4
        F = @(windspeed) tacoma([0 500], [0 0 0.001 0], 0.04, 5, 1* 10^-7, windspeed, false);
        windspeed = bisection(F, 40, 100, 1* 10^-7);
        windspeed
        tacoma([0 500], [0 0 0.001 0], 0.04, 5, 1* 10^-7, windspeed, false)
        
    % Exercise 5
    case 5
        F = @(a,b,c,d,e,f,g) tacoma(a,b,c,d,e,f,g);
        
    % Exercise 6
    case 6
        xPlotPosition = [];
        yPlotPosition = [];
        theta = 0.0000001;
        windspeed = 150;  % starting windspeed
        mf = 0.000000002; % multiplicationfactor
        n = 50; % steps that will be iterated
        for (i = 0: n)
            angularMagnification = tacoma([0 1000], [1 0 (theta + (i * mf)) 0], 25000, 5, 0.0000001, windspeed, false);
            xPlotPosition = [xPlotPosition (theta + (i * mf))];
            yPlotPosition = [yPlotPosition angularMagnification];
            graph = plot(xPlotPosition, yPlotPosition);
        end
        % axis([ 0, t(1)+50, 0, yLim ]); % axis defined with calibration
        grid % grid enabled
    
    % Exercise 7
    case 7
        newOmega = 2 * normalOmega;
        tacoma([0 500], [0 0 0.001 0], 0.04, 5, 1* 10^-6, 58.99, 3, true)
        tacoma([0 500], [0 0 0.001 0], 0.04, 5, 1* 10^-6, 58.99, normalOmega, false)
        tacoma([0 500], [0 0 0.001 0], 0.04, 5, 1* 10^-6, 58.99, normalOmega * 2, false)
        % tacoma([0 500], [0 0 0.001 0], 0.04, 5, 1* 10^-6, 58.99, normalOmega * 2, true)
end
