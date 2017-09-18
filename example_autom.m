
% Anta at vi har likningen
% x'=f1(t,x,y)=t*cos(y)
% y'=f2(t,x,y)=  sin(x*y)
 
%F�rst implementerer vi h�yresiden som en vektorfunksjon
 
F0 = @(t,x,y) [t*cos(y) sin(x*y)]; %
 
% For � lage et autonomt system lar vi Y=[t x y] % I kommentarene er '
% den deriverte.
% da er Y'=[t' x' y']=[1 f1(t,x,y) f2(t,x,y)]
% Autonomt system:
% Y' = G(Y) = [1 f1(t,x,y) f2(t,x,y)] = [1 F0(t,x,y)]
 
G = @(Y) [1 F0(Y(1),Y(2),Y(3))];