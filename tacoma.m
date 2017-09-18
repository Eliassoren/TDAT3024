%Program 6.6 Animation program for bridge using IVP solver
%Inputs: time interval inter,
% ic=[y(1,1) y(1,2) y(1,3) y(1,4)],
% number of steps n, steps per point plotted p
%Calls a one-step method such as trapstep.m
%Example usage: tacoma([0 1000],[1 0 0.001 0],25000,5)
function tacoma(inter, ic, n, p)
    warning('off', 'all');
    % ic: [y y' ? ?']
    % clf % clear figure window
    h = (inter(2) - inter(1)) / n;
    y(1, :) = ic; % enter initial conds in y
    t(1) = inter(1); 
    len = 6;
    
    yMax = 0;
    xPlot = [];
    yPlot = [];

    for k = 1:n
        for i = 1:p
            t(i + 1) = t(i) + h;
            y(i + 1, :) = trapstep(t(i), y(i, :), h);
        end
        
        y(1, :) = y(p + 1, :);
        t(1) = t(p + 1);
        
        z1(k) = y(1, 1);
        z3(k) = y(1, 3);
        
        c = len * cos(y(1, 3));
        s = len * sin(y(1, 3));
        
        subplot(2,2,1);
        set(gca, 'XLim', [-8 8], 'YLim', [-8 8], ...
        'XTick', [-8 0 8], 'YTick', [-8 0 8], ...
        'Drawmode', 'fast', 'Visible', 'on', 'NextPlot', 'add');
        cla; % clear screen
        axis square % make aspect ratio 1-1
        
        road = line('color', 'b', 'LineStyle', ' - ', 'LineWidth', 5, ...
    'erase', 'xor', 'xdata', [-c c], 'ydata', [-s-y(1, 1) s-y(1, 1)]);
    lcable = line('color', 'r', 'LineStyle', ' - ', 'LineWidth', 1, ...
    'erase', 'xor', 'xdata', [-c -c], 'ydata', [-s-y(1, 1) 8]);
    rcable = line('color', 'r', 'LineStyle', ' - ', 'LineWidth', 1, ...
    'erase', 'xor', 'xdata', [c c], 'ydata', [s-y(1, 1) 8]);

    drawnow;
    subplot(2, 2, 2);
    if abs(y(1,3)) > yMax
        yMax = abs(y(1,3));
    end
    
    yLim = (yMax + yMax*0.2);
    xPlot = [xPlot t(1)];
    yPlot = [yPlot y(1,3)];
    
    graph = plot(xPlot, yPlot);
    axis([ 0, k+50, -yLim, yLim ]);
      grid
      drawnow;
        pause(h)
        if ~ishghandle(graph) || ~ishghandle(road)
            return
        end
    end