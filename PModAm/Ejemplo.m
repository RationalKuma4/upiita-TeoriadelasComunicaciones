clear all;
close all;
clc;

fs=44000;
ts=1/fs;
t=-10:ts:10-ts;
A=4;
w=linspace(-fs/2,fs/2,22000)*2*pi;

m=exp(-1*abs(t-1));
c=cos(10000);

%% Mensaje
figure(1);
subplot(2,1,1);
plot(t,m);
xlabel('$t$','Interpreter','latex');
ylabel('$m(t)$','Interpreter','latex');
title('$Mensaje$','Interpreter','latex');
grid on;

subplot(2,1,2);
Y=fftshift(fft(m,22000))*ts;
plot(w,abs(Y));
xlabel('$w$','Interpreter','latex');
ylabel('$w(t)$','Interpreter','latex');
title('$Espectro$','Interpreter','latex');
grid on;