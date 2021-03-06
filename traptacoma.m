% Program 6.6 Animation program for bridge using IVP solver
% Inputs: 
    % inter: tidsintervall 
    % ic=[y(1,1) y(1,2) y(1,3) y(1,4)]: initialverdier 
    % h: steglengde
    % p: steg per punkt plottet
    % W: vindhastighet i km/h
    % runGraph: Kj�r enten grafing eller computing
    % omega: svingningskoeffisient
    % d: dempningskoeffisient
% Kaller enstegs metode som trapstep.m eller fehlbergstep.m
% Eksempel: tacoma([0 1000],[1 0 0.001 0],0.04,5,true)
function [yMaxAngleMagnify, timeelapsed, yHistory] = traptacoma(inter, ic, h0, p, W, omega, d, runGraph)
    if (runGraph)
        clf % clear figure window
    end
    yHistory = [];
    k = 1; % Foerste steg initert
    h = h0; % Steglengde
    n = (inter(2)-inter(1))/h;
    y(1, :) = ic; % Legg inn initalverdier i systemet
    t(1) = inter(1); % Legg starttid
    len = 6;

    initialAngle = y(1,3); % Startvinkel fra initialverdier
    
    yMaxAngleMagnify = 0; % Denne variabelen brukes i computing og er derfor definert her
    
    if (runGraph)  
        % These tables contain the values being plotted 
        % into each graph and subgraph
        xPlot = [];
        yPlot = [];
        yPlotPosition = [];
        yPlotAngleMagnify = [];

        % warning('off', 'all');

        % Define axes
        figureAxes = subplot(3, 3, 1);
        angleGraphAxes = subplot(3, 3, 2);
        bridgePositionAxes = subplot(3, 3, 3);
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
    
    tic;
    for k = 1:n
        for i = 1:p
            k = k + 1;
            y(i+1,:) = trapstep(t(i), y(i,:), h, W, omega, d);

            t(i+1) = t(i)+h;
            
            [m, n] = size(yHistory);
            if(m < 5000)
                yHistory = [y(i+1,:) t(i + 1) ; yHistory];
            end
        end
       
        y(1, :) = y(p+1, :);
        t(1) = t(p+1);
        
        angleMagnify = y(1,3) / initialAngle;
        if (abs(angleMagnify) > yMaxAngleMagnify) % calibration
            yMaxAngleMagnify = abs(angleMagnify);
        end
        
        if (runGraph)
            c = len * cos(y(1, 3));
            s = len * sin(y(1, 3));
            set(road, 'xdata', [-c c], 'ydata', [-s-y(1, 1) s-y(1, 1)])
            set(lcable, 'xdata', [-c -c], 'ydata', [-s-y(1, 1) 8])
            set(rcable, 'xdata', [c c], 'ydata', [s-y(1, 1) 8])
    
            xPlot = [xPlot t(1)];
            % Angle subgraph
            % The values for the current iteration are saved
            yPlot = [yPlot y(1,3)];

            plot(angleGraphAxes, xPlot, yPlot); % The graph plots the points given
            title(angleGraphAxes, 'Angle'); % Subgraph title
            xlabel(angleGraphAxes, 'Time (s)') % x-axis label
            ylabel(angleGraphAxes, 'Angle (radians)') % y-axis label
            grid(angleGraphAxes);

            % Next subplot
            % These points will be plotted
            yPlotPosition = [yPlotPosition y(1,1)];

            % The graph is drawn
            plot(bridgePositionAxes, xPlot, yPlotPosition);

            title(bridgePositionAxes, 'Y-position of bridge'); % Title set, has to be done after graph
            xlabel(bridgePositionAxes, 'Time (s)') % x-axis label
            ylabel(bridgePositionAxes, 'height (m)') % y-axis label
            grid(bridgePositionAxes);
            
            % Next subplot
            % ANGLE MAGNIFICATION
            
            % These points will be drawn
            yPlotAngleMagnify = [yPlotAngleMagnify angleMagnify];

            % Points get drawn
            plot(angleMagnificationPlotAxes, xPlot, yPlotAngleMagnify);

            title(angleMagnificationPlotAxes, 'Angle magnification'); % Title
            xlabel(angleMagnificationPlotAxes, 'Time (s)') % x-axis label
            ylabel(angleMagnificationPlotAxes, 'Angle magnification') % y-axis label
            grid(angleMagnificationPlotAxes); % grid enabled

            drawnow limitrate;
            pause(h);
        end
    end
    timeelapsed = toc;
end



 
  