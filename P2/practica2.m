close all;
clear all;

%% Graficas Funcion mensaje
f1=400/2*pi;
T1=2*pi/(400);
f_max=1100;
fs=50*f_max;
ts=1/fs;
t=-3*T1:ts:3*T1;

m=2*cos(400*t)+4*sin(500*t+pi/3);
figure(1);
subplot(2, 1, 1)
plot(t,m);
xlabel('$t$','Interpreter','latex');
ylabel('$m(t)$','Interpreter','latex');
title('Función mensaje')
grid on;

w=(-100:100)*2*pi;  
t=-20*T1:ts:20*T1;
m=2*cos(400*t)+4*sin(500*t+pi/3);
M=0;
n=0;
for tt=t
    n=n+1;
    M=M+m(n)*exp(-1i*w*tt)*ts;
end

subplot(2, 1, 2)
plot(w/2*pi,abs(M));
xlabel('$w$','Interpreter','latex');
ylabel('$M(w)$','Interpreter','latex');
title('Espectro')
grid on;

%% Graficas Funcion Portadora
t=-T1:ts:T1;
c=10*cos(1000*pi*t);

figure(2);
subplot(2,1,1);
plot(t,c);
xlabel('$t$','Interpreter','latex');
ylabel('$c(t)$','Interpreter','latex');
title('Funcion portadora')
grid on;

w=(-1000:1000)*2*pi;  %En radianes rads
t=-20*T1:ts:20*T1;
c=10*cos(1000*pi*t);
C=0;
n=0;
for tt=t
    n=n+1;
    C=C+c(n)*exp(-1i*w*tt)*ts;
end

subplot(2, 1, 2)
plot(w/2*pi,abs(C));
xlabel('$w$','Interpreter','latex');
ylabel('$C(w)$','Interpreter','latex');
title('Espectro')
grid on;

%% Modulacion
t=-2*T1:ts:2*T1;
m=2*cos(400*t)+4*sin(500*t+pi/3);
c=10*cos(1000*pi*t);
y=m.*c;

figure(3);
subplot(2,1,1);
plot(t,y);
xlabel('$t$','Interpreter','latex');
ylabel('$y(t)$','Interpreter','latex');
title('Funcion modulada')
grid on;

w=(-1000:1000)*2*pi;  %En radianes rads
t=-20*T1:ts:20*T1;
m=2*cos(400*t)+4*sin(500*t+pi/3);
c=10*cos(1000*pi*t);
y=m.*c;

Y=0;
n=0;
for tt=t
    n=n+1;
    Y=Y+y(n)*exp(-1i*w*tt)*ts;
end
subplot(2,1,2);
plot(w/2*pi,abs(Y));
xlabel('$w$','Interpreter','latex');
ylabel('$Y(w)$','Interpreter','latex');
title('Espectro')
grid on;

%% Demodulacion
t=-2*T1:ts:2*T1;
m=2*cos(400*t)+4*sin(500*t+pi/3);
c=10*cos(1000*pi*t);
y=m.*c;
yd=y.*c;

figure(4);
subplot(2,1,1);
plot(t,yd);
xlabel('$t$','Interpreter','latex');
ylabel('$y(t)$','Interpreter','latex');
title('Funcion demodulada')
grid on;

w=(-1000:1000)*2*pi;  %En radianes rads
t=-20*T1:ts:20*T1;
m=2*cos(400*t)+4*sin(500*t+pi/3);
c=10*cos(1000*pi*t);
y=m.*c;
yd=y.*c;

YD=0;
n=0;
for tt=t
    n=n+1;
    YD=YD+yd(n)*exp(-1i*w*tt)*ts;
end
subplot(2,1,2);
plot(w/2*pi,abs(YD));
xlabel('$w$','Interpreter','latex');
ylabel('$Y(w)$','Interpreter','latex');
title('Espectro')
grid on;

