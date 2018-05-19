% A=5
% A*3
% B=A*3
% C=[2,2,1,4]
% D=[3,4,1,3;4,2,1,5]
% E=[2;4;5;7]
% F=[2 4 5 7]' 
% clear B
% clear all
% x=[0,1,2,3]
% plot(x)
% 
% t=[-2 -1 0 1]
% plot(t,x)
% 
% t=-5:0.1:5;
% f=t.^2
% plot(t,f)
%nombre del arichivo sin espacios 
%Este programa es mi primera experiencia en matlab
%sirve para calcular una funcion al cuadrado y una la cubo 
%%
clc
clear all
close all
t=-5:0.1:5;
f=t.^2;
y=t.^3;
hold on 
plot(t,f)
plot(t,y)
hold off
y=t.^3;
plot(t,y,'-ro')
figure(10);
t=0:0.1:2*pi;
z=cos(t)
plot(t,z,'-bo')

