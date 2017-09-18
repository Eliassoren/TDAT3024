
% Anta at vi har likningen
% x'=f1(t,x,y)=t*cos(y)
% y'=f2(t,x,y)=  sin(x*y)
 
%Først implementerer vi høyresiden som en vektorfunksjon
 
F0 = @(t,x,y) [t*cos(y) sin(x*y)]; %
 
% For å lage et autonomt system lar vi Y=[t x y] % I kommentarene er '
% den deriverte.
% da er Y'=[t' x' y']=[1 f1(t,x,y) f2(t,x,y)]
% Autonomt system:
% Y' = G(Y) = [1 f1(t,x,y) f2(t,x,y)] = [1 F0(t,x,y)]
 
G = @(Y) [1 F0(Y(1),Y(2),Y(3))];