%% Datos iniciales
clear all;
close all;
clc;

kp=10*pi;
kf=30000*pi;
fc=50*10^3;
fs=10*10^6;
ts=1/fs;

t1=0:ts:1*10^-4-ts;
m1=(2*10^4)*(t1-.5*10^-4);
t2=1*10^-4:ts:2*10^-4-ts;
m2=-(2*10^4)*(t1-.5*10^-4);
t=[t1 t2];
m=[m1 m2];

%% a) Graficar m(t)
figure(1);
plot(t,m);
title('Mensaje')
xlabel('$t$','Interpreter','latex');
ylabel('$m(t) $','Interpreter','latex');
grid on;

%% b) a(t)=Int(m(t),-Inf,t)
a=0;
n=0;
for tt=t
    n=n+1;
    a(n+1)=a(n)+m(n)*ts;
end

a(length(a))=[];
figure(2);
plot(t,a);
title('$\int_{-\infty }^{t} m(\alpha) d\alpha $','Interpreter','latex')
xlabel('$t$','Interpreter','latex');
ylabel('$a$','Interpreter','latex');
grid on;

%% c) m'(t)
dm=[diff(m) 0];
figure(3);
plot(t,dm);
title('$ m''(t) $','Interpreter','latex')
xlabel('$t$','Interpreter','latex');
ylabel('$ m''(t)$','Interpreter','latex');
grid on;

%% d) ypm=cos(2pifct+kpm(t))
ypm=cos(2*pi*fc*t+kp*m);
% figure(4);
% plot(t,ypm);
% title('$ y_{pm}=cos(2 \pi fc t + kp m(t)) $','Interpreter','latex')
% xlabel('$ t $','Interpreter','latex');
% ylabel('$y_{pm}$','Interpreter','latex');
% grid on;

%% e) yfm=cos(2pifct+kf*Int(m(t))dt)
yfm=cos(2*pi*fc*t+kf*a);
% figure(5);
% plot(t,yfm);
% title('$ y_{pm}=cos(2 \pi fc t + kp m(t)) $','Interpreter','latex')
% xlabel('$ t $','Interpreter','latex');
% ylabel('$y_{pm}$','Interpreter','latex');
% grid on;

%% Graficas
figure(4);
subplot(3,1,1);
plot(t,m);
title('Mensaje')
xlabel('$t$','Interpreter','latex');
ylabel('$m(t) $','Interpreter','latex');
grid on;

subplot(3,1,2);
plot(t,ypm);
title('$ y_{pm}=cos(2 \pi fc t + kp m(t)) $','Interpreter','latex')
xlabel('$ t $','Interpreter','latex');
ylabel('$y_{pm}$','Interpreter','latex');
grid on;

subplot(3,1,3);
plot(t,yfm);
title('$ y_{fm}=cos(2 \pi fc t + kf \int_{-\infty }^{t} m(\alpha) d\alpha) $'...
    ,'Interpreter','latex')
xlabel('$ t $','Interpreter','latex');
ylabel('$y_{fm}$','Interpreter','latex');
grid on;

