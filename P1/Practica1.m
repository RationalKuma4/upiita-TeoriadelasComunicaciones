clear all;
close all;
clc;

%% 1a)
F=239;
T=1/F;
t=linspace(0,3*T);
x=@(t) 3*cos(2*pi*F*t);
figure(1);
plot(t, x(t))
% xlabel('$1-a$','Interpreter','latex');
% ylabel('$m(t)$','Interpreter','latex');
title('1-a','Interpreter','latex')
grid on;

%% 1b)
F=7/44;
T=1/F;
t=linspace(0,5*T);
x=@(t) 2*sin(2*pi*F*t);
figure(2);
plot(t, x(t))
title('1-b','Interpreter','latex')
grid on;

%% 1c)
Tp=1/25;
t=linspace(0,2*Tp,1000000);
x=4*cos(2*pi*175*t)+7*sin(2*pi*375*t);
figure(3);
plot(t, x);
title('1-c','Interpreter','latex')
grid on;

%% 2a)

%% 2b)

%% 2c)
F=1/2*pi;
T=1/F;
fs=44000;
ts=1/fs;
t=0:ts:T-ts;

x=power(sin(2*pi*F*t),5);
figure(4);
plot(t,x);
title('2-c','Interpreter','latex');
grid on;


X=fftshift(fft(x,100))*ts;
w=linspace(-fs/2,fs/2,length(X))*2*pi;
figure(5);
stem(w, abs(X));
title('Espectro','Interpreter','latex');
grid on;

%% 3a)

%% 3b)

%% 3c)

%% 4a)

%% 4b)
F=1/2*pi;
T=1/F;
fs=44000;
ts=1/fs;
t=0:ts:T-ts;
x=exp(3*abs(t));
figure(7);
plot(t,x);
title('4-b','Interpreter','latex')
grid on;

X=fftshift(fft(x,50));
w=linspace(-fs/2,fs/2,length(X))*2*pi;

figure(8);
stem(w, abs(X));
title('Espectro','Interpreter','latex')
grid on;

%% 5a)
fun = @(x) sin(x)./x;
%fun = @(x) exp(-x.^2).*log(x).^2;
q = integral(fun,0-Inf,Inf);



