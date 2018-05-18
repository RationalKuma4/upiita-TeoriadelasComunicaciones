clc;
clear all;
close all;

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
 n=0;
 Int_m=0;
 for tt=t
      n=n+1;
      Int_m(n+1)=Int_m(n)+m(n)*ts;
 end
 
 figure(2)
 plot(Int_m)
 title('funcion integral')
  figure(3)
 plot(t,[diff(m) 0]/ts)
 title('diferencial')
 
 YPM=cos(2*pi*fc*t+10*pi*m);
 figure(4)
 subplot(311)
 plot(t,m)
 subplot(312)
 plot(t,YPM);
 title('YPM')
 
 
 YFM=cos(2*pi*fc*t+2E5*pi*(Int_m(1:length(Int_m)-1)));
 subplot(3,1,3);
 plot(t,YFM)
  title('YFM')