clear all;
close all;
fs = 1000;
t = 0: 1/fs :1;
mt = cos(2*pi.*t);
xt = cos(100*pi.*t);
AM_t = mt.*xt;

subplot(6,2,1);
plot(t,mt,'r','linewidth',2);
xlabel('tiempo [s]');
ylabel('Amplitud');
grid on;
title 'Señal modulante';
hold on;

subplot(6,2,2);
plot(t,xt,'b','linewidth',2);
xlabel('tiempo [s]');
ylabel('Amplitud');
grid on;
title 'Señal portadora';
hold on;

subplot(6,2,3:4);
plot(t,AM_t,'g','linewidth',2);
xlabel('tiempo [s]');
ylabel('Amplitud');
grid on;
title 'Portadora modulada';
hold on;

%%Segunda Parte
N = 10*length(t);
Fnorm = fs*(-N/2 : (N/2)-1)/N;
Es_m = fftshift(abs(fft(mt,N)));
Es_x = fftshift(abs(fft(xt,N)));
Es_AM = fftshift(abs(fft(AM_t,N)));
fc = 50;
fm = 1;

subplot(6,2,5);
plot(Fnorm,Es_m,'r','linewidth',2);
xlabel('frecuencia [Hz]');
ylabel('|F(w)|');
grid on;
title 'Espectro de señal modulante';
xlim([-100 100]);
hold on;

subplot(6,2,6);
plot(Fnorm,Es_x,'b','linewidth',2);
xlabel('frecuencia [Hz]');
ylabel('|F(w)|');
grid on;
title 'Espectro de señal portadora';
xlim([-100 100]);
hold on;

subplot(6,2,7:8);
plot(Fnorm,Es_AM,'g','linewidth',2);
xlabel('frecuencia [Hz]');
ylabel('|F(w)|');
grid on;
title 'Espectro de portadora modulada';
xlim([-100 100]);
hold on;

%%Tercera parte
Smod = ammod(mt,fc,fs);
Sdemod = amdemod(AM_t,fc,fs);

subplot(6,2,9);
plot(t,Smod,'r','linewidth',2);
xlabel('tiempo [s]');
ylabel('Amplitud');
grid on;
title 'ammod';
hold on;

subplot(6,2,10);
plot(t,Sdemod,'b','linewidth',2);
xlabel('tiempo [s]');
ylabel('Amplitud');
grid on;
title 'amdemod';
hold on;

subplot(6,2,11:12);
plot(t,mt,'g','linewidth',2);
xlabel('tiempo [s]');
ylabel('Amplitud');
grid on;
title 'señal original';
hold on;