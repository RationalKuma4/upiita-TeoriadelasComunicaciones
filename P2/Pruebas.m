clear all;
close all;

f1=400/2*pi;
T1=2*pi/(400);

f_max=1100;
fs=50*f_max;
ts=1/fs;
%t=-3*T1:ts:3*T1;    %Periodo pequeño
t=-3*T1:ts:3*T1;
%tiempo mas muestras
m=cos(1000*t).*cos(3000*t);
figure(1);
subplot(2, 1, 1)
plot(t,m);
% hold on;
% x1=4*sin(500*t+pi/3);
% plot(t,x1,'r');
% hold on;
% plot(t, x+x1,'g');
%t=-20*T1:ts:20*T1;
w=(-100:100)*2*pi;  %En radianes rads
t=-20*T1:ts:20*T1;
m=2*cos(400*t)+4*sin(500*t+pi/3);
M=0;
n=0;
for tt=t
    n=n+1;
    M=M+m(n)*exp(-1*j*w*tt)*ts;
end
subplot(2, 1, 2)
%espectro muchas muestras
%plot(w,abs(M));
plot(w/2*pi,abs(M));