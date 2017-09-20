% ([interval],initial conds,#of steps,steps per plotpoint,err
% tolerance, Windspeed in km/h)

runGraph = true; %Set this to true to run graph
if (runGraph)
    tacoma([0 1000], [1 0 0.002 0], 25000, 5, 0.0000001, 62);
end


% ([interval],initial conds,#of steps,steps per plotpoint, W = Windspeed
% Exercise 4 (finding minimum windspeed inwhich a angular
% magnification of 100 or more occurs

runComputing = false; % Change this to true to run code below
%EXERCISE 4 -------------------------------------------------------
if runComputing
    windspeed = 50;  %starting windspeed
    n = 50; %steps that will be iterated
    for i = 0: n
        angularMagnification = tacomaComputing([0 1000], [1 0 0.002 0], 25000, 5, 0.0000001, windspeed+i);
        if angularMagnification > 100
            angularMagnification
            windspeed = windspeed + i
            break
        end
    end
end

%EXERCISE 5 -------------------------------------------------------
