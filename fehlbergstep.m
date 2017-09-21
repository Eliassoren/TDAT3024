% Input
    % t: Tidsvariabelen
    % y: Høyreside av ODE
    % h: Steglengde
    % tol: Feiltoleranse
% Outputs
    % Wout: Nytt system for y
    % E: Feilkilde fra numerisk løsning
% Eksempelbruk i løkke
    % fehlbergstep(t(i,:), y(i,:), h);
function [ Wout , E ] = fehlbergstep( t, y, h, W)
   % Konstantverdier fra runge-kutta-fehlbergs metode
   A=[ 1/4        0         0         0        0;
        3/32       9/32      0         0        0;
     1932/2197 -7200/2197 7296/2197    0        0;
      439/216     -8      3680/513  -845/4104   0;
       -8/27       2     -3544/2565 1859/4104 -11/40];

   
   B=[ 25/216 0 1408/2565  2197/4104   -1/5  0;
       16/135 0 6656/12825 28561/56430 -9/50 2/55];
   
   C = [ 1/4 3/8 12/13 1 1/2];
   
   % Stegene i metoden
    s1=ydot(t, y, W);
    s2=ydot(t+C(1)*h, y+h*(A(1,1)*s1), W);
    s3=ydot(t+C(2)*h, y+h*(A(2,1)*s1+A(2,2)*s2), W);
    s4=ydot(t+C(3)*h, y+h*(A(3,1)*s1+A(3,2)*s2+A(3,3)*s3), W);
    s5=ydot(t+C(4)*h, y+h*(A(4,1)*s1+A(4,2)*s2+A(4,3)*s3+A(4,4)*s4), W);
    s6=ydot(t+C(5)*h, y+h*(A(5,1)*s1+A(5,2)*s2+A(5,3)*s3+A(5,4)*s4+A(5,5)*s5), W);
    
    % Zout, 5. ordens løsning
    Zout=y+h*(B(1,1)*s1+B(1,2)*s2+B(1,3)*s3+B(1,4)*s4+B(1,5)*s5+B(1,6)*s6);
    % Wout, 4. ordens løsning
    Wout=y+h*(B(2,1)*s1+B(2,2)*s2+B(2,3)*s3+B(2,4)*s4+B(2,5)*s5+B(2,6)*s6);
    % E=norm( (h/360)*s1-(128*h/4275)*s3-(2197*h/75240)*s4+(h/50)*s5+(2*h/55)*s6,2);
    E=abs(norm(Wout-Zout,2));
   
end

