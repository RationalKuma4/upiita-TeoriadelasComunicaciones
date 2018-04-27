close all;
clear all;

fs=100; %veces*frecuencia
ts=1/fs;
t=-10:ts:10;
%% Determinar las series de fourier
% a
m1=0;
for n=-50:50
    m1=m1+0.5*(sinc(n/2)).^2*exp(j*n*pi*t);
end

figure(1);
subplot(2, 1, 1);
plot(t, real(m1));
grid on;

w=(-150:ts:150)*2*pi;
M1=0;
n=0;
for tt=t
    n=n+1;
    M1=M1+m1(n)*exp(-j*w*tt)*ts;
end
subplot(2,1,2) %Hertz radianis sin 2*pi
plot(w/(2*pi),abs(M1));
grid on;

%%
t=-.5:ts:.5;
c=cos(2*pi*50*t);
figure(2);
subplot(2,1,1)
plot(t,c);

w=(-150:0.01:150)*2*pi;
C=0;
n=0;
for tt=t
    n=n+1;
    C=C+c(n)*exp(-j*w*tt)*ts;
end
subplot(2,1,2) %Hertz radianis sin 2*pi
plot(w/(2*pi),abs(C));
grid on;

%%
y=m1.*c;
figure(3);
subplot(2,1,1);
plot(t,y);
grid on;

w=(-150:0.01:150)*2*pi;
Y=0;
n=0;
for tt=t
    n=n+1;
    Y=Y+y(n)*exp(-j*w*tt)*ts;
end
subplot(2,1,2) %Hertz radianis sin 2*pi
plot(w/(2*pi),abs(C));
grid on;

%%
s=y.*c;
figure(4);
subplot(2,1,1);
plot(t,s);
grid on;

w=(-150:0.01:150)*2*pi;
S=0;
n=0;
for tt=t
    n=n+1;
    S=S+s(n)*exp(-j*w*tt)*ts;
end
subplot(2,1,2) %Hertz radianis sin 2*pi
plot(w/(2*pi),abs(S));
grid on;

%% filtro
I=find(abs(w)>=6*2*pi); %&regresa posiciones ue cumplen con la condicion

Filtro=ones(1,length(w));
Filtro(I)=0;
figure(5);
plot(w,Filtro);

%% Aplicacion filtro
M2=S.*Filtro;
n=0;
m2=0;
for ww=w
    n=n+1;
    m2=m2+M2(n)*exp(j*ww*t)*.01;
end
figure(6);
plot(t,real(m2));

%% Modulacion no coherente
I=find(y<0); %Simulamos un iodo
yy=y;
yy(I)=0;

w=(-150:0.01:150)*2*pi;
YY=0;
n=0;
for tt=t
    n=n+1;
    YY=YY+yy(n)*exp(-j*w*tt)*ts;
end
figure(7) %Hertz radianis sin 2*pi
plot(w/(2*pi),abs(YY));
grid on;
% Calcular tranformada de fourier de yy
%Ponemos capacitor
M3=YY.*Filtro;
n=0;
m3=0;
for ww=w
    n=n+1;
    m3=m3+M3(n)*exp(j*ww*t)*.01;
end
figure(8);
plot(t,real(m3));
