sampFreq = 1000;
t = 0:1/1000:1;

subplot(3,1,1)
mt=cos(2*pi*t);
title('Mensaje')
plot(t,mt)

subplot(3,1,2)
xct = cos(100*pi*t);
title('Portadora')
plot(t,xct)

subplot(3,1,3)
pm = mt .* xct;
title('Portadora Modulada')
plot(t,pm)

figure
subplot(3,1,1)
N = 10*1001;
specMsg = fftshift(abs(fft(mt,N)));
fnorm = 1000*((-N/2 : (N/2)-1)/N);
plot(fnorm,specMsg)
xlim([-100 100])

subplot(3,1,2)
N = 10*1001;
specPort = fftshift(abs(fft(xct,N)));
fnorm = 1000*((-N/2 : (N/2)-1)/N);
plot(fnorm,specPort)
xlim([-100 100])

subplot(3,1,3)
N = 10*1001;
specPortMod = fftshift(abs(fft(pm,N)));
fnorm = 1000*((-N/2 : (N/2)-1)/N);
plot(fnorm,specPortMod)
xlim([-80 80])

figure
subplot(2,1,1)
plot(ammod(mt,50,1000))
subplot(2,1,2)
plot(amdemod(pm,50,1000))