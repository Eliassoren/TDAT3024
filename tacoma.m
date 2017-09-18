%Program 6.6 Animation program for bridge using IVP solver
%Inputs: time interval inter,
% ic=[y(1,1) y(1,2) y(1,3) y(1,4)],
% number of steps n
% steps per point plotted p
% tol: tolerance of error
%Calls a one-step method such as trapstep.m
%Example usage: tacoma([0 1000],[1 0 0.001 0],25000,5)

function tacoma(inter, ic, n, p, tol)
    clf % clear figure window
    h = (inter(2) - inter(1)) / n;
    y(1, :) = ic; % enter initial conds in y
    t(1, :) = inter(1); % t values in right side ode
    e(1, :) = 0.01; % error
    len = 6;
    
    %These values are used for calibrating the graphs so the height
    %is dynamicaly changed to fit for the current values
    yMax = 0; 
    yMaxYPosition = 0;
    yMaxError = 0;
    yMaxStepLength = 0;

    
    %These tables contain the values being plotted 
    %into each graph and subgraph
    xPlot = [];
    yPlot = [];
    xPlotPosition = [];
    yPlotPosition = [];
    xPlotError = [];
    yPlotError = [];
    xPlotStepLength = [];
    yPlotStepLength = [];
    warning('off', 'all');

    for k = 1:n
        for i = 1:p
            t(i+1,:) = t(i,:)+h;
            [w,err] = fehlbergstep(t(i,:), y(i,:), h);
            y(i+1,:) = w;
            e(i+1,:) = err;
            h = h* 0.8 * (tol/e(i+1,:))^(1/4);
            while e(i+1,:) > tol % Try again until toleration is met
                % Another try after adjustment
                [w,err] = fehlbergstep(t(i,:), y(i,:), h);
                y(i+1,:) = w;
                e(i+1,:) = err;
                
                if e(i+1,:) > tol
                    h = h / 2; % Reduce step size h to reduce error
                end
            end
        end
        
        y(1, :) = y(p+1, :);
        t(1, :) = t(p+1, :);
        e(1, :) = e(p+1, :);
        z1(k) = y(1, 1);
        z3(k) = y(1, 3);
        
        c = len * cos(y(1, 3));
        s = len * sin(y(1, 3));
        
        subplot(3,3,1);
        set(gca, 'XLim', [-6.5 6.5], 'YLim', [-20 20], ...
        'XTick', [-6 0 6], 'YTick', [-16 -12 -8 -4 0 4 8 12 16], ...
        'Drawmode', 'fast', 'Visible', 'on', 'NextPlot', 'add');
        cla; % clear screen
        axis square % make aspect ratio 1-1
        
        road = line('color', 'b', 'LineStyle', ' - ', 'LineWidth', 5, ...
    'erase', 'xor', 'xdata', [-c c], 'ydata', [-s-y(1, 1) s-y(1, 1)]);
    lcable = line('color', 'r', 'LineStyle', ' - ', 'LineWidth', 1, ...
    'erase', 'xor', 'xdata', [-c -c], 'ydata', [-s-y(1, 1) 8]);
    rcable = line('color', 'r', 'LineStyle', ' - ', 'LineWidth', 1, ...
    'erase', 'xor', 'xdata', [c c], 'ydata', [s-y(1, 1) 8]);
    
    title('Tacoma bridge simulation'); %graph title
    xlabel('Width (m)') % x-axis label
    ylabel('Height (m)') % y-axis label
    
    drawnow;
    subplot(3, 3, 2); %Angle subgraph
    if abs(y(1,3)) > yMax
        yMax = abs(y(1,3)); %Calibrating the graph
    end
    
    %Graph index is calibrated by this value
    yLim = (yMax + yMax*0.2); 
    
    %The values for the current iteration are saved
    xPlot = [xPlot t(1)];
    yPlot = [yPlot y(1,3)];
    
    graph = plot(xPlot, yPlot); %The graph plots the points given
    
    title('Angle'); %Subgraph title
    xlabel('Time (s)') % x-axis label
    ylabel('Angle (radians)') % y-axis label
    
    %The axis is drawn given the calibration value calculated earlier
    axis([ 0, t(1)+50, -yLim, yLim ]); 
      grid %This enables the grid
        pause(h)
        
    %if the window is closed the loop exits
    if ~ishghandle(graph) || ~ishghandle(road)
        return 
    end
    
    %Next subplot
    subplot(3,3,3); %Y position
    if abs(y(1,1)) > yMaxYPosition
        yMaxYPosition = abs(y(1,1)); %Calibration
    end
    
    yLim = (yMaxYPosition); %Calibration value
    
    %These points will be plotted
    xPlotPosition = [xPlotPosition t(1)];
    yPlotPosition = [yPlotPosition y(1,1)];
    
    %The graph is drawn
    graph = plot(xPlotPosition, yPlotPosition);
    
    title('Y-position of bridge'); %Title set, has to be done after graph
    xlabel('Time (s)') % x-axis label
    ylabel('height (m)') % y-axis label
    
    axis([ 0, t(1)+50, -yLim, yLim ]); %axis defined with calibration
    grid
    
    %Next subplot
    subplot(3,3,4); %ERROR
    if abs(e(1,1)) > yMaxError
        yMaxError = abs(e(1,1)); %Calibration
    end
    
    yLim = (yMaxError + yMaxError*0.2); %Calibration value
    
    %Points for plotting
    xPlotError = [xPlotError t(1)]; 
    yPlotError = [yPlotError e(1,1)];
    
    %Plot drawn
    graph = plot(xPlotError, yPlotError);
    
    title('Error'); %Title of graph
    xlabel('Time (s)') % x-axis label
    ylabel('Error (m)') % y-axis label
    
    axis([ 0, t(1)+50, 0, yLim ]); %axis defined with calibration
    grid
    
    %Next subplot
    s5 = subplot(3,3,5); %STEP LENGTH
    subplot(s5, 'stepLength', 'm');
    if abs(h) > yMaxStepLength %calibration
        yMaxStepLength = abs(h);
    end
    
    yLim = (yMaxStepLength + yMaxStepLength*0.2);%calibration value
    
    %These points will be drawn
    xPlotStepLength = [xPlotStepLength t(1)];
    yPlotStepLength = [yPlotStepLength h];
    
    %Points get drawn
    graph = plot(xPlotStepLength, yPlotStepLength);
    
    title('Steplength'); %Title
    xlabel('Time (s)') % x-axis label
    ylabel('Step length') % y-axis label
    
    axis([ 0, t(1)+50, 0, yLim ]); %axis defined with calibration
    grid %grid enabled
    
    
    
    end