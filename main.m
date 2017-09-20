% ([interval],initial conds,#of steps,steps per plotpoint,err
% tolerance, Windspeed in km/h)

runGraph = false; %Set this to true to run graph
if (runGraph)
    tacoma([0 1000], [1 0 0.002 0], 25000, 5, 0.0000001, 63);
end


% ([interval],initial conds,#of steps,steps per plotpoint, W = Windspeed
% Exercise 4 (finding minimum windspeed inwhich a angular
% magnification of 100 or more occurs

exercise4 = false; % Change this to true to run code below
%EXERCISE 4 -------------------------------------------------------
if exercise4
    windspeed = 200;  %starting windspeed
    n = 0; %steps that will be iterated
    for i = 0: n
        angularMagnification = tacomaComputing([0 1000], [1 0 0.000001 0], 25000, 5, 0.0000001, windspeed);
        if angularMagnification > 100
            angularMagnification
            windspeed = windspeed
            break
        end
    end
end

%EXERCISE 3 -------------------------------------------------------
exercise3 = false;

if exercise3
    windspeed = 50;  %starting windspeed
    angularMagnificationTheta1 = tacomaComputing([0 1000], [1 0 0.001 0], 25000, 5, 0.0000001, windspeed);
    angularMagnificationTheta1
    angularMagnificationTheta2 = tacomaComputing([0 1000], [1 0 0.0001 0], 25000, 5, 0.0000001, windspeed);
    angularMagnificationTheta2
    angularMagnificationTheta3 = tacomaComputing([0 1000], [1 0 0.00001 0], 25000, 5, 0.0000001, windspeed);
    angularMagnificationTheta3
    angularMagnificationTheta3
    %Is the angle magnification approx consistent. YES
end


%EXERCISE 6 --------------------------------------------------------

exercise6 = true;
xPlotPosition = [];
yPlotPosition = [];
if exercise6
    theta = 0.00004;
    windspeed = 200;  %starting windspeed
    mf = 0.000002; %multiplicationfactor
    n = 15; %steps that will be iterated
    for i = 0: n
        angularMagnification = tacomaComputing([0 1000], [1 0 (theta + (i * mf)) 0], 25000, 5, 0.0000001, windspeed);
        xPlotPosition = [xPlotPosition (theta + (i * mf))];
        yPlotPosition = [yPlotPosition angularMagnification];
        graph = plot(xPlotPosition, yPlotPosition);
    end
    %axis([ 0, t(1)+50, 0, yLim ]); %axis defined with calibration
    grid %grid enabled
    
end