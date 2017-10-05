% ([intervall],initialverdier[y y' theta theta'],antall steg,steg per plotpoint, toleranse, vindhastighet km/h, boolean kjor grafing eller computing)

% Standard verdi for koeffisienter
normalOmega = 2 * pi * 38 / 60;
normalDempningsKoff = 0.01;

runGraph = true; % Sett til true for Ã¥ rendre grafer
exercise = 7; % Hvilken oppgave som skal kjÃ¸res

switch (exercise)
    % Exercise 1 TODO: Use tacoma with trapstep instead of Fehlberg
    case 1
        traptacoma([0 500], [0 0 0.001 0], 0.04, 5, 59, normalOmega, normalDempningsKoff, runGraph)
    
    % Exercise 2
    case 2
        tacoma([0 500], [0 0 0.001 0], 0.0000004, 5, 1* 10^-6, 80, normalOmega, normalDempningsKoff, runGraph);
        
    % Exercise 3
    case 3
        % TODO: Bruk en for-lÃ¸kke for Ã¥ teste flere initialverdier for vind
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
        windspeed = bisection(F, 56, 58, tolerance);
        
        % The value below should be over 100
        angleMagnification = tacoma([0 500], [0 0 0.001 0], 0.0000004, 5, tolerance, windspeed, normalOmega, normalDempningsKoff, false);
        fprintf('Bijeksjonsmetoden ga rot på W = %d km/t\n', windspeed);
        fprintf('Kjøres simulasjonen med W = %d km/t, er vinkelforstørrelsen %d\n', windspeed, angleMagnification);
    % Exercise 6
    case 6
        % TODO: Oppgaven sier at man skal prøve flere verdier for
        % vindhastighet, vi bruker kun én
        theta = 1 * 10^-7;
        windspeed = 150;  % starting windspeed
        mf = 2 * 10^-8; % multiplicationfactor
        n = 10; % steps that will be iterated
        k = 5; % windspeeds that will be iterated
        hold on
        for (j = 0: k)
            xPlotPosition = [];
            yPlotPosition = [];
            for (i = 0: n)
                angularMagnification = tacoma([0 500], [0 0 (theta + (i * mf)) 0], 0.04 ,5, 1 * 10^-6, windspeed, normalOmega, normalDempningsKoff, false);
                if (angularMagnification < 100)
                    i
                    angleMag = (theta + (i * mf))
                end
                xPlotPosition = [xPlotPosition (theta + (i * mf))];
                yPlotPosition = [yPlotPosition angularMagnification];
            end
            % Plotter en ny graf for hver endring i vindhastighet
            plot(xPlotPosition, yPlotPosition);
            windspeed = windspeed + 10;
        end
        hold off
        % axis([ 0, t(1)+50, 0, yLim ]); % axis defined with calibration
        grid % grid enabled
    
    % Exercise 7
    case 7
        tolerance = 0.5 * 10^-3;
        newOmega = 3;
        newD = normalDempningsKoff * 2; % 0.02
        tacoma([0 500], [0 0 0.001 0], 0.04, 5, 1* 10^-6, 58.99, newOmega, normalDempningsKoff, false)
        tacoma([0 500], [0 0 0.001 0], 0.04, 5, 1* 10^-6, 58.99, newOmega, newD, false)
        
        F_old = @(windspeed) tacoma([0 500], [0 0 0.001 0], 0.04, 5, tolerance, windspeed, newOmega, normalDempningsKoff, false) - 100;
        F_new = @(windspeed) tacoma([0 500], [0 0 0.001 0], 0.04, 5, tolerance, windspeed, newOmega, newD, false) - 100;
        windspeed_old = bisection(F_old, 1, 120, tolerance);
        windspeed_new = bisection(F_new, 1, 120, tolerance);
        
        fprintf('Min. vindhastighet for d = 0.01, omega = 3: %d km/t\n', windspeed_old);
        fprintf('Min. vindhastighet for d = 0.02, omega = 3: %d km/t\n', windspeed_new);
        
        % Koden under plotter alle 3 ulike vinkelforstÃ¸rrelser ved de ulike
        % d- og omega-parametrene
        xVal = 0 : 0.5 : 120;
        yValOriginal = zeros(120/0.5, 1);
        yValOld = zeros(120/0.5, 1);
        yValNew = zeros(120/0.5, 1);
        counter = 1;
        for i = 0 : 0.5 : 120
            yValOriginal(counter) = tacoma([0 500], [0 0 0.001 0], 0.04, 5, tolerance, i, normalOmega, normalDempningsKoff, false);
            yValOld(counter) = tacoma([0 500], [0 0 0.001 0], 0.04, 5, tolerance, i, newOmega, normalDempningsKoff, false);
            yValNew(counter) = tacoma([0 500], [0 0 0.001 0], 0.04, 5, tolerance, i, newOmega, newD, false);
            counter = counter + 1;
        end
        
        hold on
        plot(xVal, yValOriginal);
        plot(xVal, yValOld);
        plot(xVal, yValNew);
        refline(0, 100); % Horisontal linje pÃ¥ y = 100
        hold off
        axis([0 120 0 200]);
        legend({'$d = 0.01, \omega = 2\pi*\frac{38}{60}$', '$d = 0.01, \omega = 3$', '$d = 0.02, \omega = 3$'},'Interpreter','latex');
        xlabel('Vindhastighet (km/t)');
        ylabel('VinkelforstÃ¸rring');
        grid
end
