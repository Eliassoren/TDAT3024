function ydot=old_ydot(t,y,W,omega,d)
len=6;a=0.2; 
a1=exp(a*(y(1)-len*sin(y(3))));
a2=exp(a*(y(1)+len*sin(y(3))));
ydot(1)=y(2);
ydot(2)=-d*y(2)-0.4*(a1+a2-2)/a+0.2*W*sin(omega*t);
ydot(3)=y(4);
ydot(4)=-d*y(4)+1.2*cos(y(3))*(a1-a2)/(len*a);