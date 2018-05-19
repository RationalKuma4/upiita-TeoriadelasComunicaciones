clear all
close all

t=0:0.01:3*pi;
%x=sin(t)./t
%x(1)=1;
x=sinc(t);
plot(t,x);

grid on