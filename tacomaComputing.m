% Program 6.6 Animation program for bridge using IVP solver
% Inputs: time interval inter,
% ic=[y(1,1) y(1,2) y(1,3) y(1,4)],
% number of steps n
% steps per point plotted p
% tol: tolerance of error
% Calls a one-step method such as trapstep.m
% Example usage: tacoma([0 1000],[1 0 0.001 0],25000,5)

function [yMaxAngleMagnify] = tacoma(inter, ic, n, p, tol, W)
    h = (inter(2) - inter(1)) / n;
    y(1, :) = ic; % enter initial conds in y
    t(1, :) = inter(1); % t values in right side ode
    e(1, :) = 0.1; % error
    startError = 0.1; % This has to be SAME as the error above
    len = 6;
    initialAngle = y(1,3); % The initial angle from the initial conditions
    
    % These values are used for calibrating the graphs so the height
    % is dynamicaly changed to fit for the current values
    yMax = 0; 
    yMaxYPosition = 0;
    yMaxError = 0;
    yMaxStepLength = 0;
    yMaxErrorMagnify = 0;
    yMaxAngleMagnify = 0;
    
    % This value is for finding if the error is magnified by 100 or more
    errorMagnify = 0;
    angleMagnify = 0;
    
    % These tables contain the values being plotted 
    % into each graph and subgraph
    xPlotAngleMagnify = [];
    yPlotAngleMagnify = [];
    warning('off', 'all');

    for k = 1:n
        for i = 1:p
            t(i+1,:) = t(i,:)+h;
            [w, err] = fehlbergstep(t(i,:), y(i,:), h, W);
            y(i+1,:) = w;
            e(i+1,:) = err;
            h = h* 0.8 * (tol/e(i+1,:))^(1/4);
            while e(i+1,:) > tol % Try again until toleration is met
                % Another try after adjustment
                [w,err] = fehlbergstep(t(i,:), y(i,:), h, W);
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
    
    % Next subplot
    angleMagnify = y(1,3) / initialAngle;
    if abs(angleMagnify) > yMaxAngleMagnify % calibration
        yMaxAngleMagnify = abs(angleMagnify);
    end
   
    end