clc;
clear all;
close all;

T=10e-3;
fc=30e3;
fs=50*fc;
ts=1/fs;
t=-.5e-3:ts:.5e-3-ts;
t=-.5e-3:ts:3.5e-3-ts;
w=linspace(-fs/2,fs/2,22000)*2*pi;
kp=pi/2;
kf=20000*pi;

%% Serie 
m=0;
for v=-6:6
    if(v~=0)
        m=m+1i*(cos(v*pi)/(v*pi))*exp(1i*2000*pi*v*t);
    end
end

%% Grafica
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

%% e) yfm=cos(2pifct+kf*Int(m(t))dt)
yfm=cos(2*pi*fc*t+kf*a);

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

%% Graficas espectros
figure(5);
subplot(3,1,1);
M=fftshift(fft(m,22000))*ts;
plot(w,abs(M));
title('Mensaje')
xlabel('$w$','Interpreter','latex');
ylabel('$M(t) $','Interpreter','latex');
axis([-8e4 8e4 0 1.4e-3])
grid on;

subplot(3,1,2);
Ypm=fftshift(fft(ypm,22000))*ts;
plot(w,abs(Ypm));
title('$ Y_{pm}=cos(2 \pi fc t + kp m(t)) $','Interpreter','latex')
xlabel('$ w $','Interpreter','latex');
ylabel('$Y_{pm}$','Interpreter','latex');
axis([-3e5 3e5 0 14e-4])
grid on;

subplot(3,1,3);
Yfm=fftshift(fft(yfm,22000))*ts;
plot(w,abs(Yfm));
title('$ Y_{fm}=cos(2 \pi fc t + kf \int_{-\infty }^{t} m(\alpha) d\alpha) $'...
    ,'Interpreter','latex')
xlabel('$ w $','Interpreter','latex');
ylabel('$Y_{fm}$','Interpreter','latex');
axis([-3e5 3e5 0 6e-4])
grid on;
