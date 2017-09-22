% ([intervall],initialverdier[y y' theta theta'],antall steg,steg per plotpoint, toleranse, vindhastighet km/h)

runGraph = true; % Set this to true to run graph
exercise3 = false;
exercise4 = false;
exercise6 = false;

if (runGraph)
    tacoma([0 1000], [1 0 0.002 0], 25000, 5, 0.0000001, 63);
end

% Exercise 4 (finding minimum windspeed inwhich a angular
% magnification of 100 or more occurs

% EXERCISE 4 -------------------------------------------------------
if (exercise4)
    windspeed = 60;  % start vindhastighet
    n = 20; % steg som vil bli iterert

    for (i = 0: n)
        angularMagnification = tacomaComputing([0 1000], [1 0 0.000001 0], 25000, 5, 0.0000001, windspeed + i);
        if (angularMagnification > 100)
            angularMagnification
            windspeed = windspeed + i
            break
        end
    end
end

% EXERCISE 3 -------------------------------------------------------
if (exercise3)
    windspeed = 50;  % starting windspeed
    angularMagnificationTheta1 = tacomaComputing([0 1000], [1 0 0.001 0], 25000, 5, 0.0000001, windspeed)
    angularMagnificationTheta2 = tacomaComputing([0 1000], [1 0 0.0001 0], 25000, 5, 0.0000001, windspeed)
    angularMagnificationTheta3 = tacomaComputing([0 1000], [1 0 0.00001 0], 25000, 5, 0.0000001, windspeed)
    % Is the angle magnification approx consistent. YES
end


% EXERCISE 6 --------------------------------------------------------
xPlotPosition = [];
yPlotPosition = [];
if (exercise6)
    theta = 0.0000001;
    windspeed = 150;  % starting windspeed
    mf = 0.000000002; % multiplicationfactor
    n = 10; % steps that will be iterated
    for (i = 0: n)
        angularMagnification = tacomaComputing([0 1000], [1 0 (theta + (i * mf)) 0], 25000, 5, 0.0000001, windspeed);
        xPlotPosition = [xPlotPosition (theta + (i * mf))];
        yPlotPosition = [yPlotPosition angularMagnification];
        graph = plot(xPlotPosition, yPlotPosition);
    end
    % axis([ 0, t(1)+50, 0, yLim ]); % axis defined with calibration
    grid % grid enabled
    
end