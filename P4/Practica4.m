% ==============
% Message Signal
% ==============
t1 = -0.02:1.e-4:0;
t2 = 0:1.e-4:0.02;
Ta = 0.01;
m1 = 1 - abs((t1+Ta)/Ta);
m1 = [zeros([1 200]),m1,zeros([1 400])];
m2 = 1 - abs((t2-Ta)/Ta);
m2 = [zeros([1 400]),m2,zeros([1 200])];
m = m1 - m2;

t = -0.04:1.e-4:0.04;
fc = 400;                                             % Frquency of carrier wave
c = cos(2*fc*pi*t);                                   % Carrier

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
title('Message Signal');
xlabel('{\it t} (sec)');
ylabel('m(t)');
grid;

subplot(2,2,2);
plot(t,ssb);
title('MODULATED SIGNAL');
xlabel('{\it t} (sec)');
ylabel('LSB(t)');
grid;

subplot(2,2,3);
plot(t,dem);
title('De-Modulated');
xlabel('{\it t} (sec)');
grid;

subplot(2,2,4);
plot(t,rec);
title('Recovered Signal');
xlabel('{\it t} (sec)');
ylabel('m(t)');
grid;

% ================================
% Ploting Freq Responce of Signals
% ================================

figure(2);
subplot(2,2,1);                                     
plot(f,abs(mF));
title('Freq Responce of Message Signal');
xlabel('f(Hz)');
ylabel('M(f)');
grid;
axis([-600 600 0 200]);



subplot(2,2,2);
plot(f,abs(cF));
title('Freq Responce of Carrier');
grid;
xlabel('f(Hz)');
ylabel('C(f)');
axis([-600 600 0 400]);



subplot(2,2,3);
plot(f,abs(ssbF));
title('Freq Responce of DSBSC');
xlabel('f(Hz)');
ylabel('LSB(f)');
grid;
axis([-600 600 0 200]);


subplot(2,2,4);
plot(f,abs(recF));
title('Freq Responce of Recoverd Signal');
xlabel('f(Hz)');
ylabel('M(f)');
grid;
axis([-600 600 0 100]);