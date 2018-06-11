clc;
clear all;
close all;

%%
%Frecuencia de la portadora
fc=150E3;
%Frecuencia de muestreo
fs=50*fc;
%Tiempo de muestreo
ts=1/fs;
T=2e-4;
t1=0:ts:(T/2)-ts;
m1=4/T*(t1-T/2)+1;
%m1=(2/1e-4)*(t1-0.5e-4);
%plot(t1,m1);

t2=(T/2):ts:T-ts;
m2=-4/T*(t2-T/2)+1;
%m2=-(2/1e-4)*(t2-1.5e-4);
m=[m1 m2 m1 m2 ];
t=0:ts:2*T-ts;
hold on;
plot(t,m);
title('funcion m(t)')
kp=10*pi;

%%
%Frecuencia de la portadora
fc=150E3;
%Frecuencia de muestreo
fs=50*fc;
%Tiempo de muestreo
ts=1/fs;
T=2e-4;
t1=0:ts:(T/2)-ts;
m1=ones(1,length(t1));
%m1=(2/1e-4)*(t1-0.5e-4);
plot(t1,m1);

t2=(T/2):ts:(6*T/4)-ts;
m2=-ones(1,length(t2));
t3=(6*T/4):ts:(2*T)-ts;
m3=ones(1,length(t3));
%m2=-(2/1e-4)*(t2-1.5e-4);
m=[m1 m2 m3];
t=0:ts:2*T-ts;
hold on;
plot(t,m);
%axis([0 4E4 -2 2])
axis([0 max(t) -2 2])
title('funcion m(t)')
kp=pi/2;

%%
 n=0;
 Int_m=0;
 for tt=t
      n=n+1;
      Int_m(n+1)=Int_m(n)+m(n)*ts;
 end
 
 figure(2)
 subplot(2,1,1)
 plot(Int_m)
 title('funcion integral')
 %figure(2)
 subplot(2,1,2)
 plot(t,[diff(m) 0]/ts)
 title('diferencial')
 
 YPM=cos(2*pi*fc*t+kp*m);
 figure(3)
 subplot(311)
 plot(t,m)
 title('Funcion m(t)')
 subplot(312)
 plot(t,YPM);
 title('YPM')
 
 
 YFM=cos(2*pi*fc*t+2E5*pi*(Int_m(1:length(Int_m)-1)));
 subplot(3,1,3);
 plot(t,YFM)
  title('YFM')