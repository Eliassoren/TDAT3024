% Standardverdier for argumenter
normalOmega = 2 * pi * 38 / 60;
normalDempningsKoff = 0.01;

runGraph = true; % Sett til true for å rendre grafer
exercise = 1; % Hvilken oppgave som skal kjøres

interval = [0 500];
time_sum = 0;
sim = 1; % Antall simuleringer
time_spent_fehl = 0;
time_spent_trap = 0;

switch (exercise)
    % Aktivitet 1 
    case 1
        for i=0:sim
        [angle, time, y] = traptacoma(interval, [0 0 0.001 0], 0.04, 5, 80, normalOmega, normalDempningsKoff, runGraph);
        time_sum = time_sum+time;
        end
        time_spent_trap = time_sum/sim
    % Aktivitet 2
    case 2
         for i=0:sim
           [angle, time, y] = tacoma(interval, [0 0 0.001 0], 0.0000004, 5, 1* 10^-6, 80, normalOmega, normalDempningsKoff, runGraph);
           time_sum = time_sum+time;
         end
         time_spent_fehl = time_sum/sim
        
        % Generer plott som viser forskjell mellom vinkel på trapes og
        % fehlberg
        [angleMag, time, y] = traptacoma([0 500], [0 0 0.001 0], 0.04, 5, 80, normalOmega, normalDempningsKoff, false);
        [angleMagNew, time, yNew] = tacoma([0 500], [0 0 0.001 0], 0.0000004, 5, 1* 10^-6, 80, normalOmega, normalDempningsKoff, false);
        [m, n] = size(y);
        x = 1 : m;
        hold on
        plot(y(:, 5), y(:,3));
        plot(yNew(:, 5), yNew(:,3));
        hold off
        legend('trap', 'fehlberg');

    % Aktivitet 3
    case 3
        windspeed = 50;  % starting windspeed
        n = 10; % number of iterations
        xPlotPosition = [];
        yPlotPosition = [];
        for iteration = 3: n
            angle = 1 * 10^-iteration
            angularMagnificationTheta = tacoma([0 500], [0 0 angle 0], 0.04 ,5,  1* 10^-6, windspeed, normalOmega, normalDempningsKoff, false)
            if (runGraph)
                xPlotPosition = [xPlotPosition iteration];
                yPlotPosition = [yPlotPosition angularMagnificationTheta];
                plot(xPlotPosition, yPlotPosition);
                xlabel('Startvinkel $\theta_0=10^{-x}$', 'Interpreter', 'latex');
                ylabel('Vinkelforstørrelse');
            end
        end
        % Is the angle magnification approx consistent. YES
        
    % Aktivitet 4 (finding minimum winds peed in which a angular
    % magnification of 100 or more occurs
    case 4
        tolerance = 0.5 * 10^-3;
        
        % Bruteforce
        n = 120;

        for i = 0:1:n
            angularMagnification = tacoma([0 500], [0 0 0.001 0], 0.04, 5, tolerance, i, normalOmega, normalDempningsKoff, false);
            if angularMagnification >= 100
                fprintf('Minimum vindstyrke funnet ved hjelp av bruteforce: %d km/t\n', i);
                fprintf('Vinkelforstørrelse med denne vindstyken: %d\n', angularMagnification);
                break
            end
        end
        
    % Aktivitet 5 - calculating minimum wind speed with equation solver
    case 5
        tolerance = 0.5 * 10^-3;
        
        % Defines the function and uses bisection with the defined function
        % This is so we can easily use tacoma - 100 to find roots
        F = @(windspeed) tacoma([0 500], [0 0 0.001 0], 0.0000004, 5, tolerance, windspeed, normalOmega, normalDempningsKoff, false) - 100;
        windspeed = bisection(F, 56, 58, tolerance);
        
        % The value below should be over 100
        angleMagnification = tacoma([0 500], [0 0 0.001 0], 0.0000004, 5, tolerance, windspeed, normalOmega, normalDempningsKoff, false);
        fprintf('Bijeksjonsmetoden ga rot på W = %d km/t\n', windspeed);
        fprintf('Kjøres simulasjonen med W = %d km/t, er vinkelforstørrelsen %d\n', windspeed, angleMagnification);
        
    % Aktivitet 6
    case 6
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
        grid % grid enabled
    
    % Aktivitet 7
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
        
        % Koden under plotter alle 3 ulike vinkelforstørrelser ved de ulike
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
        refline(0, 100); % Horisontal linje på y = 100
        hold off
        axis([0 120 0 200]);
        legend({'$d = 0.01, \omega = 2\pi*\frac{38}{60}$', '$d = 0.01, \omega = 3$', '$d = 0.02, \omega = 3$'},'Interpreter','latex');
        xlabel('Vindhastighet (km/t)');
        ylabel('Vinkelforstørring');
        grid
end
