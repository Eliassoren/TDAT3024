% ([intervall],initialverdier[y y' theta theta'],steglengde,steg per plotpoint, feilkilde, toleranse, vindhastighet km/h)

tacoma([0 1000], [1 0 0.002 0], 0.04, 5, 0.000001, 160);



% Exercise 4 (finding minimum windspeed inwhich a angular
% magnification of 100 or more occurs

runComputing = false; % Endre til true for å kjøre koden under

if runComputing
    windspeed = 50;  % start vindhastighet
    n = 50; % steg som vil bli iterert
    for i = 0: n
        angularMagnification = computingTraptacoma([0 1000], [1 0 0.002 0], 25000, 5, windspeed + i);
        if angularMagnification > 100
            angularMagnification
            windspeed = windspeed + i
            break
        end
    end
end