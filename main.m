% ([intervall],initialverdier[y y' theta theta'],antall steg,steg per plotpoint, toleranse, vindhastighet km/h, boolean kjor grafing eller computing)

% Standard omega-verdi
normalOmega = 2 * pi * 38 / 60;
normalDempningsKoff = 0.01;

runGraph = true; % Sett til true for å rendre grafer
exercise = 6; % Hvilken oppgave som skal kjøres
%tacoma([0 500], [0 0 0.001 0], 0.0000004, 5, 1* 10^-6, 59, normalOmega, normalDempningsKoff, false)
switch (exercise)
    % Exercise 1 TODO: Use tacoma with trapstep instead of Fehlberg
    case 1
        traptacoma([0 500], [0 0 0.001 0], 0.04, 5, 59, normalOmega, normalDempningsKoff, runGraph)
    
    % Exercise 2
    case 2
        tacoma([0 500], [0 0 0.001 0], 0.0000004, 5, 1* 10^-6, 80, normalOmega, normalDempningsKoff, runGraph);
        
    % Exercise 3
    case 3
        % TODO: Bruk en for-løkke for å teste flere initialverdier for vind
        windspeed = 50;  % starting windspeed TODO: Says 50 in the exercise?
        n = 10; % number of iterations
        xPlotPosition = [];
        yPlotPosition = [];
        for iteration = 3: n
            angle = 1 * 10^-iteration
            angularMagnificationTheta = tacoma([0 500], [0 0 (0.001 * 10^-iteration) 0], 0.04 ,5,  1* 10^-6, windspeed, normalOmega, normalDempningsKoff, false)
            if (runGraph)
                xPlotPosition = [xPlotPosition iteration];
                yPlotPosition = [yPlotPosition angularMagnificationTheta];
                graph = plot(xPlotPosition, yPlotPosition);
            end
        end
        % Is the angle magnification approx consistent. YES
        
    % Exercise 4 & 5 (finding minimum windspeed inwhich a angular
    % magnification of 100 or more occurs
    case 4
        
        tolerance = 0.5 * 10^-3;
        
        % Run this to find a interval if unsure
%       n = 100;
%       
%       for i = 0: n
%           angularMagnification = tacoma([0 500], [0 0 0.001 0], 0.04, 5, tolerance, 30 + i, normalOmega, normalDempningsKoff, false) - 100;
%           if angularMagnification > 0
%               i + 30
%               break
%           end
%       end
        
        % Defines the function and uses bisection with the defined function
        % This is so we can easily use tacoma - 100 to find roots
        F = @(windspeed) tacoma([0 500], [0 0 0.001 0], 0.0000004, 5, tolerance, windspeed, normalOmega, normalDempningsKoff, false) - 100;
        windspeed = bisection(F, 56, 58, tolerance)
        
        % The value below should be over 100
        tacoma([0 500], [0 0 0.001 0], 0.0000004, 5, tolerance, windspeed, normalOmega, normalDempningsKoff, false)
        
    % Exercise 6
    case 6
        % TODO: Oppgaven sier at man skal prøve flere verdier for
        % vindhastighet, vi bruker kun én
        xPlotPosition = [];
        yPlotPosition = [];
        theta = 1 * 10^-7;
        windspeed = 150;  % starting windspeed
        mf = 2 * 10^-8; % multiplicationfactor
        n = 10; % steps that will be iterated
        k = 5; % windspeeds that will be iterated
        for (j = 0: k)
            for (i = 0: n)
                angularMagnification = tacoma([0 500], [0 0 (theta + (i * mf)) 0], 0.04 ,5, 1 * 10^-6, windspeed, normalOmega, normalDempningsKoff, false);
                if (angularMagnification < 100)
                    i
                    angleMag = (theta + (i * mf))
                end
                xPlotPosition = [xPlotPosition (theta + (i * mf))];
                yPlotPosition = [yPlotPosition angularMagnification];
                plot(xPlotPosition, yPlotPosition);
            end
            hold on;
            windspeed = windspeed + 10;
        end
        % axis([ 0, t(1)+50, 0, yLim ]); % axis defined with calibration
        grid % grid enabled
    
    % Exercise 7
    case 7
        newOmega = 2 * normalOmega;
        tacoma([0 500], [0 0 0.001 0], 0.04, 5, 1* 10^-6, 58.99, 3, normalDempningsKoff, false)
        tacoma([0 500], [0 0 0.001 0], 0.04, 5, 1* 10^-6, 58.99, normalOmega, normalDempningsKoff, false)
        tacoma([0 500], [0 0 0.001 0], 0.04, 5, 1* 10^-6, 58.99, normalOmega * 2, normalDempningsKoff, false)
        % tacoma([0 500], [0 0 0.001 0], 0.04, 5, 1* 10^-6, 58.99, normalOmega * 2, normalDempningsKoff, true)
end
