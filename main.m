% ([interval],initial conds,#of steps,steps per plotpoint,err
% tolerance, Windspeed in km/h)

tacoma([0 1000], [1 0 0.002 0], 25000, 5, 0.0000001, 75);



% ([interval],initial conds,#of steps,steps per plotpoint, W = Windspeed
% Exercise 4 (finding minimum windspeed inwhich a angular
% magnification of 100 or more occurs

runComputing = false; %Change this to true to run code below

if runComputing
    windspeed = 50;  %starting windspeed
    n = 50; %steps that will be iterated
    for i = 0: n
        angularMagnification = computingTraptacoma([0 1000], [1 0 0.002 0], 25000, 5, windspeed + i);
        if angularMagnification > 100
            angularMagnification
            windspeed = windspeed + i
            break
        end
    end
end