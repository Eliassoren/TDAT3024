%Calls a onestep method such as trapstep.m
  %Example usage: tacoma([0 1000],[1 0 0.001 0],25000,5)
  function traptacoma(inter, ic, n, p)
     clf % clear figure window
     h = (inter(2) - inter(1)) / n;
     y(1, :) = ic; % enter initial conds in y
     t(1) = inter(1); 
     len = 6;
     set(gca, 'XLim', [-8 8], 'YLim', [-8 8], ...
     'XTick', [-8 0 8], 'YTick', [-8 0 8], ...
     'Drawmode', 'fast', 'Visible', 'on', 'NextPlot', 'add');
     cla; % clear screen
     axis square % make aspect ratio 11
     road = line('color', 'b', 'LineStyle', ' - ', 'LineWidth', 5, ...
     'erase', 'xor', 'xdata', [], 'ydata', []);
     lcable = line('color', 'r', 'LineStyle', ' - ', 'LineWidth', 1, ...
     'erase', 'xor', 'xdata', [], 'ydata', []);
     rcable = line('color', 'r', 'LineStyle', ' - ', 'LineWidth', 1, ...
     'erase', 'xor', 'xdata', [], 'ydata', []);
     for k = 1:n
         for i = 1:p
             t(i + 1) = t(i) + h;
             y(i + 1, :) = trapstep(t(i), y(i, :), h);
         end
         y(1, :) = y(p + 1, :); t(1) = t(p + 1);
         z1(k) = y(1, 1); z3(k) = y(1, 3);
         c = len * cos(y(1, 3)); s = len * sin(y(1, 3));
         set(road, 'xdata', [-c c], 'ydata', [-s-y(1, 1) s-y(1, 1)])
         set(lcable, 'xdata', [-c -c], 'ydata', [-s-y(1, 1) 8])
         set(rcable, 'xdata', [c c], 'ydata', [s-y(1, 1) 8])
         drawnow;
         drawnow;
         pause(h)
    end
 
  