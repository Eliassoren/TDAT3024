% Program 6.6 Animation program for bridge using IVP solver
% Inputs: 
    % inter: tidsintervall 
    % ic=[y(1,1) y(1,2) y(1,3) y(1,4)]: initialverdier 
    % h: steglengde
    % p: steg per punkt plottet
    % tol: feiltoleranse
    % W: vindhastighet i km/h
    % runGraph: Kjør enten grafing eller computing
    % omega: svingningskoeffisient
    % d: dempningskoeffisient
% Kaller enstegs metode som trapstep.m eller fehlbergstep.m
function [yMaxAngleMagnify, timeelapsed, yHistory] = tacoma(inter, ic, h0, p, tol, W, omega, d, runGraph)
    if (runGraph)
        clf % clear figure window
    end
    yHistory = [];
    k = 1; % Foerste steg initert
    t_tolerance = 0.01; % Toleranse paa hvor langt over inter(2) 
    h = h0; % Foerste steglengde
    y(1, :) = ic; % Legg inn initalverdier i systemet
    w(1, :) = ic; % Startverdier i tilsvarende w-tabell. For ï¿½ lagre w-verdiene
    t(1) = inter(1); % Legg starttid
    e(1) = 0.1; % Feilkilde
    h_sum = 0; % Sum av steg
    startError = e(1); 
    len = 6;
    initialAngle = y(1,3); % The initial angle from the initial conditions
    
    yMaxAngleMagnify = 0; % Denne variabelen brukes i computing og er derfor definert her
    yMaxYPosition = 0;
    
    if (runGraph)
        % This value is for finding if the error is magnified by 100 or more
        errorMagnify = 0;

        % These tables contain the values being plotted 
        % into each graph and subgraph
        xPlot = [];
        yPlot = [];
        yPlotPosition = [];
        yPlotError = [];
        yPlotStepLength = [];
        yPlotErrorMagnify = [];
        yPlotAngleMagnify = [];

        warning('off', 'all');

        % Define axes
        figureAxes = subplot(3, 3, 1);
        angleGraphAxes = subplot(3, 3, 2);
        bridgePositionAxes = subplot(3, 3, 3);
        errorPlotAxes = subplot(3, 3, 4);
        stepLengthAxes = subplot(3, 3, 5);
        errorMagnificationAxes = subplot(3, 3, 6);
        angleMagnificationPlotAxes = subplot(3, 3, 7);

        set(figureAxes, 'XLim', [-6.5 6.5], 'YLim', [-20 20], ...
            'XTick', [-6 0 6], 'YTick', [-16 -12 -8 -4 0 4 8 12 16], ...
            'Drawmode', 'fast', 'Visible', 'on', 'NextPlot', 'add');
        axis(figureAxes, 'square'); % Make aspect ratio 1:1

        title(figureAxes, 'Tacoma bridge simulation'); % graph title
        xlabel(figureAxes, 'Width (m)') % x-axis label
        ylabel(figureAxes, 'Height (m)') % y-axis label

        % Define lines for figure
        road = line(figureAxes, 'color', 'b', 'LineStyle', ' - ', 'LineWidth', 5, ...
        'erase', 'xor', 'xdata', [], 'ydata', []);
        lcable = line(figureAxes, 'color', 'r', 'LineStyle', ' - ', 'LineWidth', 1, ...
        'erase', 'xor', 'xdata', [], 'ydata', []);
        rcable = line(figureAxes, 'color', 'r', 'LineStyle', ' - ', 'LineWidth', 1, ...
        'erase', 'xor', 'xdata', [], 'ydata', []);
    
    end
    
    constant = 0.00000000001; % Konstant som er større enn 0. Benyttes for å beskytte mot svært små verdier av w. 
    tic;
    while h_sum+inter(1)  < inter(2)
        for i = 1:p
            k = k + 1;
            
            h_sum = h_sum + h; % På grunn av variabel steglengde, summer alle stegene
            [w, err, z] = fehlbergstep(t(i), y(i,:), h, W, omega, d); % Fehlberg returnerer en tabell med beregnet y-verdi w og feilkilde err.
            t(i+1) = t(i)+h;
            y(i+1,:) = w; 
            w(i+1,:) = w;
            e(i+1) = err;
            rel = e(i+1)/max(norm(y(i+1,:),2),constant);
            h = h* 0.8 * (tol*norm(y(i+1,:),2)/e(i+1))^(1/5); % Juster steglengde basert på feilkilde
            while ( rel > tol) % Proev igjen så lenge feilkilde er stoerre enn toleransen
                h = h / 2;  % Halvver steglengde om andre forsøk med fehlberg etter justering ikke funker 
                % Nytt forsøk etter første justering
                [w, err] = fehlbergstep(t(i), y(i,:), h, W, omega, d);
                y(i+1,:) = w;
                e(i+1) = err;
                rel = e(i+1)/max(norm(y(i+1,:),2),constant);
            end
            y(i+1,:) = z; % Lokal ekstrapolering. Når w er nære nok z, benytt mer nøyaktige løsning.
            
            [m, n] = size(yHistory);
            if(m < 5000)
                yHistory = [y(i+1,:) t(i + 1) ; yHistory];
            end
        end
        % Hopp et steg tilbake om summen av steg overskrider topp av
        % intervall med for mye. Hvis ikke, behold verdier fra siste iterasjon.
        if (h_sum - inter(2) > t_tolerance)
            y(1, :) = y(p, :); % Benyttes for plotting
            t(1) = t(p);
            e(1) = e(p);
        else
            y(1, :) = y(p+1, :);
            t(1) = t(p+1);
            e(1) = e(p+1);
        end
        z1(k) = y(1, 1);
        z3(k) = y(1, 3);
        
        angleMagnify = y(1,3) / initialAngle;
        if (abs(angleMagnify) > yMaxAngleMagnify) % calibration
            yMaxAngleMagnify = abs(angleMagnify);
        end
        if (abs(y(1,1)) > yMaxYPosition)
            yMaxYPosition = abs(y(1,1));
        end
        if (runGraph)
            c = len * cos(y(1, 3));
            s = len * sin(y(1, 3));
            set(road, 'xdata', [-c c], 'ydata', [s+y(1, 1) s+y(1, 1)])
            set(lcable, 'xdata', [-c -c], 'ydata', [s+y(1, 1) 8])
            set(rcable, 'xdata', [c c], 'ydata', [s+y(1, 1) 8])
    
            % Angle subgraph
            % The values for the current iteration are saved
            xPlot = [xPlot t(1)];
            yPlot = [yPlot y(1,3)];

            %hold(angleGraphAxes, 'on');
            %graph = plot(angleGraphAxes, t(1), y(1, 3), '*'); % The graph plots the points given
            %hold(angleGraphAxes, 'off');
            graph = plot(angleGraphAxes, xPlot, yPlot); % The graph plots the points given
            title(angleGraphAxes, 'Angle'); % Subgraph title
            xlabel(angleGraphAxes, 'Time (s)') % x-axis label
            ylabel(angleGraphAxes, 'Angle (radians)') % y-axis label
            grid(angleGraphAxes);

            % Next subplot
            % These points will be plotted
            yPlotPosition = [yPlotPosition y(1,1)];
            % The graph is drawn
            graph = plot(bridgePositionAxes, xPlot, yPlotPosition);

            title(bridgePositionAxes, 'Y-position of bridge'); % Title set, has to be done after graph
            xlabel(bridgePositionAxes, 'Time (s)') % x-axis label
            ylabel(bridgePositionAxes, 'height (m)') % y-axis label
            grid(bridgePositionAxes);

            % Next subplot
            % ERROR
            % Points for plotting
            yPlotError = [yPlotError e(1,1)];

            % Plot drawn
            graph = plot(errorPlotAxes, xPlot, yPlotError);

            title(errorPlotAxes, 'Error'); % Title of graph
            xlabel(errorPlotAxes, 'Time (s)') % x-axis label
            ylabel(errorPlotAxes, 'Error (m)') % y-axis label
            grid(errorPlotAxes);

            % Next subplot
            % STEP LENGTH
            
            % These points will be drawn
            yPlotStepLength = [yPlotStepLength h];

            % Points get drawn
            graph = plot(stepLengthAxes, xPlot, yPlotStepLength);

            title(stepLengthAxes, 'Steplength'); % Title
            xlabel(stepLengthAxes, 'Time (s)') % x-axis label
            ylabel(stepLengthAxes, 'Step length') % y-axis label

            %axis([ 0, t(1)+50, 0, yLim ]); % axis defined with calibration
            grid(stepLengthAxes); % grid enabled

            % Next subplot
            % ERROR MAGNIFICATION
            errorMagnify = e(1,1) / startError;

            % These points will be drawn
            yPlotErrorMagnify = [yPlotErrorMagnify errorMagnify];

            % Points get drawn
            graph = plot(errorMagnificationAxes, xPlot, yPlotErrorMagnify);

            title(errorMagnificationAxes, 'Error magnification'); % Title
            xlabel(errorMagnificationAxes, 'Time (s)') % x-axis label
            ylabel(errorMagnificationAxes, 'Error magnification') % y-axis label

            %axis([ 0, t(1)+50, 0, yLim ]); % axis defined with calibration
            grid(errorMagnificationAxes); % grid enabled

            % Next subplot
            % ANGLE MAGNIFICATION
            
            % These points will be drawn
            yPlotAngleMagnify = [yPlotAngleMagnify angleMagnify];

            % Points get drawn
            graph = plot(angleMagnificationPlotAxes, xPlot, yPlotAngleMagnify);

            title(angleMagnificationPlotAxes, 'Angle magnification'); % Title
            xlabel(angleMagnificationPlotAxes, 'Time (s)') % x-axis label
            ylabel(angleMagnificationPlotAxes, 'Angle magnification') % y-axis label

            %axis([ 0, t(1)+50, -yLim, yLim ]); % axis defined with calibration
            grid(angleMagnificationPlotAxes); % grid enabled

            drawnow limitrate;
            pause(h);

        end
    end
   
    timeelapsed = toc;
    % Fjern kommentar for å printe ut statistikk
%     fprintf('Y %d\n',yMaxYPosition);
%     fprintf('theta %d\n', yMaxAngleMagnify*ic(3));
%     fprintf('magnify %d\n',yMaxAngleMagnify);
end