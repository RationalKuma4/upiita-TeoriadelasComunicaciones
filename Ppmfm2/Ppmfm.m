clc;
clear all;
close all;
wc=2*pi*5000;
fs=50*5000;
ts=1/fs;
t=-0.04:ts:0.04-ts;
m=10*sinc(400*t);
w=linspace(-fs/2,fs/2,length(m))*2*pi;
kp=10*pi;
kf=30000*pi;

%% a) Sinc
figure(1);
subplot(2,1,1);
plot(t,m);
xlabel('$t$','Interpreter','latex');
ylabel('$m(t)$','Interpreter','latex');
title('$m(t)$','Interpreter','latex');
axis([-.02 .02 -3 11]);
grid on;

M=fftshift(fft(m))*ts;
subplot(2,1,2);
plot(w/2*pi,abs(M));
xlabel('$w$','Interpreter','latex');
ylabel('$M(w)$','Interpreter','latex');
title('$M(w)$','Interpreter','latex');
axis([-3500 3500 0 .03]);
grid on;

%% a(t)=Int(m(t),-Inf,t)
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
ypm=cos(2*pi*fs*t+kp*m);

%% e) yfm=cos(2pifct+kf*Int(m(t))dt)
yfm=cos(2*pi*fs*t+kf*a);

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

%% Graficas escala
figure(5);
subplot(3,1,1);
plot(t,m);
title('Mensaje')
xlabel('$t$','Interpreter','latex');
ylabel('$m(t) $','Interpreter','latex');
axis([-.01 .01 -3 11]);
grid on;

subplot(3,1,2);
plot(t,ypm);
title('$ y_{pm}=cos(2 \pi fc t + kp m(t)) $','Interpreter','latex')
xlabel('$ t $','Interpreter','latex');
ylabel('$y_{pm}$','Interpreter','latex');
axis([-.6e-2 .6e-2 -1 1]);
grid on;

subplot(3,1,3);
plot(t,yfm);
title('$ y_{fm}=cos(2 \pi fc t + kf \int_{-\infty }^{t} m(\alpha) d\alpha) $'...
    ,'Interpreter','latex')
xlabel('$ t $','Interpreter','latex');
ylabel('$y_{fm}$','Interpreter','latex');
axis([-.6e-2 .6e-2 -1 1]);
grid on;

