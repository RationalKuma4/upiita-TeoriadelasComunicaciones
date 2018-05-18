clear all;
close all;
clc;

fs=44000;
ts=1/fs;
t=0:ts:0.02;
A=4;
w=linspace(-fs/2,fs/2,22000)*2*pi;

m=cos(660*pi*t)+3*cos(880*pi*t);
c=cos(4000*pi*t);

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
axis([-.8e4 .8e4 0 .041]);
grid on;

%% Portadora
figure(2);
subplot(2,1,1);
plot(t,c);
xlabel('$t$','Interpreter','latex');
ylabel('$c(t)$','Interpreter','latex');
title('$Portadora$','Interpreter','latex');
axis([0 .01 -1 1]);
grid on;

subplot(2,1,2);
C=fftshift(fft(c,22000))*ts;
plot(w,abs(C));
xlabel('$w$','Interpreter','latex');
ylabel('$C(w)$','Interpreter','latex');
title('$Espectro$','Interpreter','latex');
axis([-1.8e4 1.8e4 0 10e-3]);
grid on;

%% Moduloacion AM
y_am=(A+m).*c;
figure(3);
subplot(2,1,1);
plot(t,y_am);
xlabel('$t$','Interpreter','latex');
ylabel('$y_{am}(t)$','Interpreter','latex');
title('$Modulacion AM$','Interpreter','latex');
grid on;

Y_am=fftshift(fft(y_am,22000))*ts; %revisar ts
subplot(2,1,2);
plot(w/(2*pi),abs(Y_am));
xlabel('$w$','Interpreter','latex');
ylabel('$Y_{am}(w)$','Interpreter','latex');
title('$Y_{am}$','Interpreter','latex');
axis([-3000 3000 0 0.04]);
grid on;

%% Demodulacion por dectector de envolvente
I=find(y_am<0);
r=y_am;
r(I)=0;

figure(4);
plot(t,y_am);
hold on;
plot(t,r,'r');
title('Demodulacion por dectector de envolvente');
%axis([-3000 3000 0 0.04]);
grid on;


