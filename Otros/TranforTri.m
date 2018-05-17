close all;
clear all;
clc;

fs=50*100; %veces*frecuencia
ts=1/fs;
t=-10:ts:10;
%% Determinar las series de fourier
% a
m1=0;
for n=-50:50
    m1=m1+0.5*(sinc(n/2)).^2*exp(1i*n*pi*t);
end

figure(1);
subplot(2, 1, 1);
plot(t, real(m1));
xlabel('$t$','Interpreter','latex');
ylabel('$m(t)$','Interpreter','latex');
title('$Serie$','Interpreter','latex');
grid on;

w=(-150:0.01:150)*2*pi;
M1=0;
n=0;
for tt=t
    n=n+1;
    M1=M1+m1(n)*exp(-1i*w*tt)*ts;
end
subplot(2,1,2) %Hertz radianis sin 2*pi
plot(w/(2*pi),abs(M1));
xlabel('$w$','Interpreter','latex');
ylabel('$M(w)$','Interpreter','latex');
title('$M(w)$','Interpreter','latex');
axis([-1 1 -1 11]);
grid on;

%%
t=-10:ts:10;
c=cos(2*pi*50*t);
figure(2);
subplot(2,1,1)
plot(t,c);
xlabel('$t$','Interpreter','latex');
ylabel('$c(t)$','Interpreter','latex');
title('$c(t)$','Interpreter','latex');
axis([-.1 .1 -1.1 1.1]);
grid on;

w=(-150:0.01:150)*2*pi;
C=0;
n=0;
for tt=t
    n=n+1;
    C=C+c(n)*exp(-1i*w*tt)*ts;
end
subplot(2,1,2) %Hertz radianis sin 2*pi
plot(w/(2*pi),abs(C));
xlabel('$w$','Interpreter','latex');
ylabel('$C(w)$','Interpreter','latex');
title('$C(w)$','Interpreter','latex');
axis([-60 60 -.5 11]);
grid on;

%%
y=m1.*c;
figure(3);
subplot(2,1,1);
plot(t,y);
xlabel('$t$','Interpreter','latex');
ylabel('$y(t)$','Interpreter','latex');
title('$y(t)$','Interpreter','latex');
axis([-1.1 1.1 -1.1 1.1]);
grid on;

w=(-150:0.01:150)*2*pi;
Y=0;
n=0;
for tt=t
    n=n+1;
    Y=Y+y(n)*exp(-1i*w*tt)*ts;
end
subplot(2,1,2) %Hertz radianis sin 2*pi
plot(w/(2*pi),abs(C));
xlabel('$w$','Interpreter','latex');
ylabel('$Y(w)$','Interpreter','latex');
title('$Y(w)$','Interpreter','latex');
axis([-60 60 -.5 11]);
grid on;

%%
s=y.*c;
figure(4);
subplot(2,1,1);
plot(t,s);
xlabel('$s$','Interpreter','latex');
ylabel('$s(t)$','Interpreter','latex');
title('$s(t)$','Interpreter','latex');
axis([-1.1 1.1 -.1 1.1]);
grid on;

w=(-150:0.01:150)*2*pi;
S=0;
n=0;
for tt=t
    n=n+1;
    S=S+s(n)*exp(-1i*w*tt)*ts;
end
subplot(2,1,2) %Hertz radianis sin 2*pi
plot(w/(2*pi),abs(S));
xlabel('$w$','Interpreter','latex');
ylabel('$S(w)$','Interpreter','latex');
title('$S(w)$','Interpreter','latex');
axis([-104 104 -.1 5.5]);
grid on;

%% filtro
I=find(abs(w)>=6*2*pi); %&regresa posiciones ue cumplen con la condicion
Filtro=ones(1,length(w));
Filtro(I)=0;
figure(5);
plot(w,Filtro);
xlabel('$w$','Interpreter','latex');
ylabel('$H(w)$','Interpreter','latex');
title('$H(w)$','Interpreter','latex');
axis([-50 50 -.1 1.5]);
grid on;

%% Aplicacion filtro
M2=S.*Filtro;
n=0;
m2=0;
for ww=w
    n=n+1;
    m2=m2+M2(n)*exp(1i*ww*t)*.01;
end
figure(6);
plot(t,real(m2));
xlabel('$m$','Interpreter','latex');
ylabel('$m(t)$','Interpreter','latex');
title('Filtro aplicado');
axis([-8 8 0 .5]);
grid on;

%% Modulacion no coherente
I=find(y<0); %Simulamos un iodo
yy=y;
yy(I)=0;

w=(-150:0.01:150)*2*pi;
YY=0;
n=0;
for tt=t
    n=n+1;
    YY=YY+yy(n)*exp(-1i*w*tt)*ts;
end
figure(7) %Hertz radianis sin 2*pi
plot(w/(2*pi),abs(YY));
xlabel('$m$','Interpreter','latex');
ylabel('$m(t)$','Interpreter','latex');
title('Filtro modulacion no coherente');
axis([-103 103 0 3.3]);
grid on;

%% Calcular tranformada de fourier de yy
%Ponemos capacitor
M3=YY.*Filtro;
n=0;
m3=0;
for ww=w
    n=n+1;
    m3=m3+M3(n)*exp(1i*ww*t)*.01;
end
figure(8);
plot(t,real(m3));
xlabel('$m$','Interpreter','latex');
ylabel('$m(t)$','Interpreter','latex');
title('Demodulacion no coherente');
axis([-8 8 0 .35]);
grid on;
