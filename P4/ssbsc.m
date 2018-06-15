t0=0.15;
fc=250;
ts=0.0001;
fs=1/ts;
t=0:ts:2*t0/3;
w=(-1000:1000)*2*pi;
c=cos(2*pi*fc*t);
m=1.*(0<=t & t<t0/3)-2.*(t0/3<=t & t<2*t0/3)+0;                               % Carrier

% ==========
% Modulation
% ==========
dsb =  2*m.*c;

% =================
% FOURIER TRANSFORM
% =================
fl = length(t);
fl = 2^ceil(log2(fl));
f = (-fl/2:fl/2-1)/(fl*1.e-4);
mF = fftshift(fft(m,fl));                               % Frequency Responce of Message Signal
cF =  fftshift(fft(c,fl));                              % Frequency Responce of Carrier Signal
dsbF = fftshift(fft(dsb,fl));                           % Frequency Responce of DSBSC

% ====================
% IDEAL FILTER FOR SSB
% ====================

ssbfilt = zeros(1,fl);
lssb = floor(fc*1.e-4*fl);
ssbfilt(fl/2-lssb+1:fl/2+lssb) = ones(1,2*lssb);
ssbF = dsbF.*ssbfilt;
ssb = real(ifft(fftshift(ssbF)));
ssb = ssb(1:length(t));

% ====================================
% De-Modulation By Synchoronous Method
% ====================================
dem = ssb.*c;

% ==============================
% Filtering out High Frequencies
% ==============================
a = fir1(25,100*1.e-4);
b = 1;
rec = filter(a,b,dem);


recF = fftshift(fft(rec,fl));                           % Frequency Responce of Recovered Message Signal

% =============================
% Ploting signal in time domain
% =============================

figure(1);
subplot(2,2,1);                                 
plot(t,m);
title('Mensaje')
xlabel('$t$','Interpreter','latex');
ylabel('$m(t) $','Interpreter','latex');
grid;

subplot(2,2,2);
plot(t,ssb);
title('Señal modulada')
xlabel('$t$','Interpreter','latex');
ylabel('$LSB(t) $','Interpreter','latex');
grid on;

subplot(2,2,3);
plot(t,dem);
title('Mensaje demoudlado');
%xlabel('$t$','Interpreter','latex');
%ylabel('$LSB(t) $','Interpreter','latex');
grid;

subplot(2,2,4);
plot(t,rec);
title('Señal recuperada');
xlabel('$t$','Interpreter','latex');
ylabel('m(t) $','Interpreter','latex');
grid;

% ================================
% Ploting Freq Responce of Signals
% ================================

figure(2);
subplot(2,2,1);                                     
plot(f,abs(mF));
title('Espectro mensaje');
xlabel('f(Hz)','Interpreter','latex');
ylabel('M(f)','Interpreter','latex');
grid;
axis([-600 600 0 200]);

subplot(2,2,2);
plot(f,abs(cF));
title('Espectro portadora');
grid;
xlabel('f(Hz)','Interpreter','latex');
ylabel('C(f)','Interpreter','latex');
axis([-600 600 0 400]);

subplot(2,2,3);
plot(f,abs(ssbF));
title('Espectro SSB');
xlabel('f(Hz)','Interpreter','latex');
ylabel('LSB(f)','Interpreter','latex');
grid;
axis([-600 600 0 200]);


subplot(2,2,4);
plot(f,abs(recF));
title('Espectro mensaje recuperado');
xlabel('f(Hz)','Interpreter','latex');
ylabel('M(f)','Interpreter','latex');
grid;
axis([-600 600 0 100]);