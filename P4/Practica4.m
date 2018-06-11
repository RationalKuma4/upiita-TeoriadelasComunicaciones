%% Datos iniciales
clear all;
close all;
clc;

t0=0.15;
fc=250;
ts=0.0001;
fs=1/ts;
t=0:ts:2*t0/3;
w=(-1000:1000)*2*pi;
c=cos(2*pi*fc*t);
m=1.*(0<=t & t<t0/3)-2.*(t0/3<=t & t<2*t0/3)+0;

%% a) Graficar m(t)
figure(1);
subplot(2,2,1)
plot(t,m);
title('Mensaje')
xlabel('$t$','Interpreter','latex');
ylabel('$m(t) $','Interpreter','latex');
grid on;

% Espectro m
M=EspectroNumerico(m,t,ts,w);
subplot(2,2,2)
plot(w/2*pi,abs(M));
title('Espectro')
xlabel('$w$','Interpreter','latex');
ylabel('$M(w)$','Interpreter','latex');
grid on;

% Portadora
subplot(2,2,3)
plot(t,c);
title('Portadora')
xlabel('$t$','Interpreter','latex');
ylabel('$c(t) $','Interpreter','latex');
grid on;

C=EspectroNumerico(c,t,ts,w);
subplot(2,2,4)
plot(w/2*pi,abs(C));
title('Espectro')
xlabel('$w$','Interpreter','latex');
ylabel('$M(w)$','Interpreter','latex');
grid on;

%% b) Se�al Modulada y demodulada DSB-SC
ydsbsc=m.*c;
figure(2);
subplot(2,2,1)
plot(t,ydsbsc);
title('$y_{DSB-SC}(t)$','Interpreter','latex')
xlabel('$t$','Interpreter','latex');
ylabel('$y_{DSB-SC}$','Interpreter','latex');
grid on;

YDSBSC=EspectroNumerico(ydsbsc,t,ts,w);
subplot(2,2,2)
plot(w/2*pi,abs(YDSBSC));
title('Espectro')
xlabel('$w$','Interpreter','latex');
ylabel('$y_{DSB-SC}(w)$','Interpreter','latex');
grid on;

% Demodulacion
ydsbscd=ydsbsc.*c;
subplot(2,2,3)
plot(t,ydsbscd);
title('$y_{DSB-SC}(t)*c$','Interpreter','latex')
xlabel('$t$','Interpreter','latex');
ylabel('$y_{DSB-SC}*c$','Interpreter','latex');
grid on;

YDSBSCD=EspectroNumerico(ydsbscd,t,ts,w);
subplot(2,2,4)
plot(w,abs(YDSBSCD));
title('$Y_{DSB-SC}(t)*c$','Interpreter','latex')
xlabel('$w$','Interpreter','latex');
ylabel('$Y_{DSB-SC}*c$','Interpreter','latex');
grid on;

% Filtro y aplicacion
th=-2*t0/3:ts:2*t0/3;
w=(-1000:1000)*2*pi;
h=(700/pi)*sinc(700*th/pi);
H=EspectroNumerico(h,th,ts,w);

figure(3);
subplot(2,2,1)
plot(th,h);
title('$h(t)$','Interpreter','latex')
xlabel('$t$','Interpreter','latex');
ylabel('$h$','Interpreter','latex');
grid on;

subplot(2,2,2)
plot(w,abs(H));
title('$H(w)$','Interpreter','latex')
xlabel('$w$','Interpreter','latex');
ylabel('$H(w)$','Interpreter','latex');
grid on;

% Aplicacion filtro
m2=conv(ydsbscd,h)*ts;
tf=linspace(-fs/2,fs/2,length(m2));

subplot(2,2,3:4)
plot(tf, m2);
title('$m(t)$','Interpreter','latex')
xlabel('$t$','Interpreter','latex');
ylabel('$m(t)$','Interpreter','latex');
grid on;

%% Se�al modula y demodulada com miu=0.85
miu=0.85;
A=abs(min(m))/miu;
yam=(A+m).*c;

figure(4);
subplot(2,2,1)
plot(t, yam);
title('$m_{AM}(t)$','Interpreter','latex')
xlabel('$t$','Interpreter','latex');
ylabel('$m_{AM}$','Interpreter','latex');
grid on;

YAM=EspectroNumerico(yam,t,ts,w);
subplot(2,2,2)
plot(w, abs(YAM));
title('$M_{AM}(t)$','Interpreter','latex')
xlabel('$w$','Interpreter','latex');
ylabel('$M_{AM}$','Interpreter','latex');
grid on;

% Demodulacion por dectector de envolvente
I=find(yam<0);
r=yam;
r(I)=0;

subplot(2,2,3:4)
plot(t,yam);
hold on;
plot(t,r,'r');
title('$m_{AM}(t)$','Interpreter','latex')
xlabel('$tw$','Interpreter','latex');
ylabel('$m_{AM}$','Interpreter','latex');
grid on;

%% Se�al modulada y demodulada SSB-SC
% dsb=2*m.*c;
% figure(5);
% subplot(2,2,1);
% plot(t,dsb);
% title('$y_{SSB-SC}(t)$','Interpreter','latex')
% xlabel('$t$','Interpreter','latex');
% ylabel('$y_{SSB-SC}$','Interpreter','latex');
% grid on;
% 
% YSSBSC=EspectroNumerico(dsb,t,ts,w);
% subplot(2,2,2)
% plot(w/2*pi,abs(YSSBSC));
% title('Espectro')
% xlabel('$w$','Interpreter','latex');
% ylabel('$y_{DSB-SC}(w)$','Interpreter','latex');
% grid on;
% 
% % Filtro idela para demodulacion
% fl = length(t);
% fl = 2^ceil(log2(fl));
% f = (-fl/2:fl/2-1)/(fl*1.e-4);
% mF = fftshift(fft(m,fl));                               % Frequency Responce of Message Signal
% cF =  fftshift(fft(c,fl));                              % Frequency Responce of Carrier Signal
% dsbF = fftshift(fft(dsb,fl));   
% 
% ssbfilt = zeros(1,fl);
% lssb = floor(fc*1.e-4*fl);
% ssbfilt(fl/2-lssb+1:fl/2+lssb) = ones(1,2*lssb);
% ssbF = dsbF.*ssbfilt;
% ssb = real(ifft(fftshift(ssbF)));
% ssb = ssb(1:length(t));
% 
% % Apllicacion filtro y demodulacion 
% dem = ssb.*c;
% a = fir1(25,100*1.e-4);
% b = 1;
% rec = filter(a,b,dem);
% recF = fftshift(fft(rec,fl)); 
% 
% subplot(2,2,3)
% plot(t,dem);
% title('$y_{SSB-SC}(t)*c$','Interpreter','latex')
% xlabel('$t$','Interpreter','latex');
% ylabel('$y_{SSB-SC}*c$','Interpreter','latex');
% grid on;
% 
% DEM=EspectroNumerico(dem,t,ts,w);
% subplot(2,2,4)
% plot(w/2*pi,abs(DEM));
% title('$y_{SSB-SC}(t)*c$','Interpreter','latex')
% xlabel('$t$','Interpreter','latex');
% ylabel('$y_{SSB-SC}*c$','Interpreter','latex');
% grid on;



%% Se�al modulada y demodulada VSB





