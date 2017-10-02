% ([intervall],initialverdier[y y' theta theta'],antall steg,steg per plotpoint, toleranse, vindhastighet km/h, boolean kjor grafing eller computing)

% Standard omega-verdi
normalOmega = 2 * pi * 38 / 60;
normalDempningsKoff = 0.01;

runGraph = true; % Sett til true for � rendre grafer
exercise = 4; % Hvilken oppgave som skal kj�res

switch (exercise)
    % Exercise 1 TODO: Use tacoma with trapstep instead of Fehlberg
    case 1
        tacoma([0 500], [0 0 0.001 0], 0.04, 5, 1* 10^-6, 80, normalOmega, normalDempningsKoff, runGraph);
    
    % Exercise 2
    case 2
        tacoma([0 500], [0 0 0.001 0], 0.04, 5, 1* 10^-6, 80, normalOmega, normalDempningsKoff, runGraph);
        
    % Exercise 3
    case 3
        % TODO: Bruk en for-l�kke for � teste flere initialverdier for vind
        windspeed = 55;  % starting windspeed TODO: Says 50 in the exercise?
        angularMagnificationTheta1 = 100 + tacoma([0 500], [0 0 0.001 0], 0.04 ,5, 0.0000001, windspeed, normalOmega, normalDempningsKoff, false)
        angularMagnificationTheta2 = 100 + tacoma([0 500], [0 0 0.0001 0], 0.04 ,5, 0.0000001, windspeed, normalOmega, normalDempningsKoff, false)
        angularMagnificationTheta3 = 100 + tacoma([0 500], [0 0 0.00001 0], 0.04 ,5, 0.0000001, windspeed, normalOmega, normalDempningsKoff, false)
        % Is the angle magnification approx consistent. YES
        
    % Exercise 4 & 5 (finding minimum windspeed inwhich a angular
    % magnification of 100 or more occurs
    case 4
        
%       n = 100;
%       interval = 0;
%         
%       for interval = 0: n
%           angularMagnification = tacoma([0 500], [0 0 0.001 0], 0.04, 5, 1* 10^-7, 30 + interval, normalOmega, normalDempningsKoff, false) - 100;
%           if angularMagnification > 0
%               interval
%               break
%           end
%       end
      
     
        
        F = @(windspeed) tacoma([0 500], [0 0 0.001 0], 0.04, 5, 1* 10^-7, windspeed, normalOmega, normalDempningsKoff, false) - 100;
        windspeed = bisection(F, 40, 200, 1* 10^-7);
        windspeed
        tacoma([0 500], [0 0 0.001 0], 0.04, 5, 1* 10^-7, windspeed, normalOmega, normalDempningsKoff, false)
        
    % Exercise 6
    case 6
        % TODO: Oppgaven sier at man skal pr�ve flere verdier for
        % vindhastighet, vi bruker kun �n
        xPlotPosition = [];
        yPlotPosition = [];
        theta = 0.0000001;
        windspeed = 150;  % starting windspeed
        mf = 0.000000002; % multiplicationfactor
        n = 50; % steps that will be iterated
        for (i = 0: n)
            angularMagnification = tacoma([0 1000], [1 0 (theta + (i * mf)) 0], 25000, 5, 0.0000001, windspeed, normalOmega, normalDempningsKoff, false);
            xPlotPosition = [xPlotPosition (theta + (i * mf))];
            yPlotPosition = [yPlotPosition angularMagnification];
            graph = plot(xPlotPosition, yPlotPosition);
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
