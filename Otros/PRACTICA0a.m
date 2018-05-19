clc
clear all
close all
x=-5:0.1:5;
hold on
y=sqrt(25-x.^2);
plot(x,y,'linewidth',4)
y=-y;
plot(x,y,'linewidth',4)
axis([-7,7 -7 7])%medida de los ejes coordenados
axis('square')%unificar espacios

salto=pi;
A=6*salto;

set(gcf,'units','normalized','outerposition',[0 0 1 1])% establece las propiedades del objeto para abrir en toda la pantalla
%crea las manecillas
xr=[0 0];
yr=[0 5];
hold on
rec=plot(xr,yr)
% xr=[0 5*cos(pi/3)];
% yr=[0 5*sin(pi/3)];
% pause(1);
% delete(rec)
% rec=plot(xr,yr)
for n=0:120
    %delete(rec)
    xr=[0 5*cos((90-n*A)*pi/180)];
    yr=[0 5*sin((90-n*A)*pi/180)];
    hold on;
    rec=plot(xr,yr)
    pause(0.1);
end