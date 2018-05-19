%TEOREMA DE NIQUIST

clear all
close all
fmax=250;
Fs=50*fmax;
Ts=1/Fs;
t=0:Ts:2/60;
x=5*cos(2*pi*60*t)+2*cos(2*pi*150*t)+3*sin(2*pi*250*t);
%plot(t,x,'r');

%%
%FORMA DE INTERPOLACION DE NIQUIST
fs=1000;
ts=1/fs;
n=0:(2/60*fs);
xn=5*cos(2*pi*n*60*ts)+2*cos(2*pi*n*150*ts)+3*sin(2*pi*n*250*ts);
figure
hold on
stem(n*ts,xn)%valores de muestreo
%plot(n*ts,xn,'r')%por interpolación lineal
y=0;
for n=0:20
    y=y+xn(n+1)*sinc((t-n*ts)/ts);
    plot(t,y);
end
figure
hold on
y1=0;
for n=0:20
    y1=y1+xn(n+1)*sinc((t-n*ts)/ts);
    plot(t,y);
end 
plot(t,x,'r');

