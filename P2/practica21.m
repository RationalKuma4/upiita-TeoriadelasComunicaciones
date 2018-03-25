close all;
clear all;

% Datos Iniciales
f1=400/2*pi;
T1=2*pi/(400);
f_max=1100; %% Frecuencia propuesta para resolucion completa de problema
fs=50*f_max;%% Frecuencia de muestreo
ts=1/fs;    %% Peiodo de muestreo
t=-2*T1:ts:2*T1;
m=2*cos(400*t)+4*sin(500*t+pi/3);

%% Graficas mensaje, portadora, modulada, demodulada en timepo continuo
% Mensaje
figure(1);
subplot(4, 2, 1)
plot(t,m);
xlabel('$t$','Interpreter','latex');
ylabel('$m(t)$','Interpreter','latex');
title('$m(t)$','Interpreter','latex');
grid on;

% Portadora
c=10*cos(1000*pi*t);
subplot(4,2,3);
plot(t,c);
xlabel('$t$','Interpreter','latex');
ylabel('$c(t)$','Interpreter','latex');
title('$c(t)$','Interpreter','latex');
grid on;

% Modulada
y=m.*c;
subplot(4,2,5);
plot(t,y);
xlabel('$t$','Interpreter','latex');
ylabel('$y(t)$','Interpreter','latex');
title('$y(t)$','Interpreter','latex');
grid on;

% Demodulada
yd=y.*c;
ye=yd;
subplot(4,2,7);
plot(t,yd);
xlabel('$t$','Interpreter','latex');
ylabel('$y(t)$','Interpreter','latex');
title('$y(t)*c(t)$','Interpreter','latex')
grid on;

%% Graficas mensaje, portadora, modulada, demodulada en frecuencia
% Datos para el espectro
w=(-1000:1000)*2*pi;  %En radianes rads
t=-20*T1:ts:20*T1;
% Funciones
m=2*cos(400*t)+4*sin(500*t+pi/3);
c=10*cos(1000*pi*t);
y=m.*c;
yd=y.*c;
% Inicializamos valores para el espectro
n=0;
M=0;
C=0;
Y=0;
YD=0;
% Calculo numerico de la integral para el espectro
for tt=t
    n=n+1;
    M=M+m(n)*exp(-1i*w*tt)*ts;
    C=C+c(n)*exp(-1i*w*tt)*ts;
    Y=Y+y(n)*exp(-1i*w*tt)*ts;
    YD=YD+yd(n)*exp(-1i*w*tt)*ts;
end

subplot(4,2,2);
plot(w/2*pi,abs(M));
xlabel('$w$','Interpreter','latex');
ylabel('$M(w)$','Interpreter','latex');
title('Espectro')
grid on;

subplot(4,2,4);
plot(w/2*pi,abs(C));
xlabel('$w$','Interpreter','latex');
ylabel('$C(w)$','Interpreter','latex');
title('Espectro')
grid on;

subplot(4,2,6);
plot(w/2*pi,abs(Y));
xlabel('$w$','Interpreter','latex');
ylabel('$Y(w)$','Interpreter','latex');
title('Espectro')
grid on;

subplot(4,2,8);
plot(w/2*pi,abs(YD));
xlabel('$w$','Interpreter','latex');
ylabel('$Y(w)$','Interpreter','latex');
title('Espectro')
grid on;

%% Filtro
t=-0.1:ts:0.1;
w=(-1000:1000)*2*pi;
h=(700/pi)*sinc(700*t/pi);
n=0;
H=0;
for tt=t
    n=n+1;
    H=H+h(n)*exp(-1i*w*tt)*ts;
end
figure(2);
subplot(2,2,1);
plot(t,h);
xlabel('$t$','Interpreter','latex');
ylabel('$h(t)$','Interpreter','latex');
title('Filtro en el tiempo')
grid on;

subplot(2,2,2);
plot(w,abs(H));
xlabel('$w$','Interpreter','latex');
ylabel('$H(w)$','Interpreter','latex');
title('Espectro')
grid on;

%% Aplicacion filtro
m2=conv(ye,h)*ts;
t=linspace(-0.1,0.1,length(m2));

subplot(2,2,3:4);
plot(t, m2);
xlabel('$t$','Interpreter','latex');
ylabel('$y(t)$','Interpreter','latex');
title('Funcion Demodulada')
axis([-0.05 0.05 -300 300])
grid on;
















