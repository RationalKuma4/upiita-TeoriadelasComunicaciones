clear all;
close all;
% x=rand(1, 1e6)-0.5;
% x=10*rand(1, 1e7)-5;
% 
% [a, b]=hist(x, 20);
% base=b(2)-b(1);
% A=sum(base*a);
% a=a/A;
% 
% bar(b, a, 1);
% media=mean(x);
% varianza=var(x);

%% gaussiana
% x=randn(1, 1e7);
% x=sqrt(0.5)*randn(1, 1e7);
% 
% [a, b]=hist(x, 200);
% base=b(2)-b(1);
% A=sum(base*a);
% a=a/A;
% 
% figure(1);
% bar(b, a, 1);
% media=mean(x);
% varianza=var(x);
% figure(2);
% plot(b, a);

%% Ruido
ruido=sqrt(.1)*randn(1, 1000);
%figure(3);
%plot(ruido);
% Señal s0
s0=ones(1,100);
bits=randint(1,10)*2-1;
% Señal que se envia
s=[];
% Añadimos los bits a la señal que se encvida //correlador
for n=1:10
    s=[s s0*bits(n)];
end
figure(4);
t=0:1/100:10-1/100;
plot(t,s);
hold on; 
plot(t, s+ruido, 'g');
axis([0 10 -3 3]);

%% Correlacion ver parecido entre señales
% agregar diferencial del tiempo y frecuencia
x=randn(1, 1e6);
rx=xcorr(x,x);
figure(1)
plot(rx);
Rx=fft(rx);
figure(2);
plot(abs(Rx));
%aleatoria
%gausiana
%blanco  muestra no correlacionadas su densidad de espectwral es contsnate
% se le suma al aseñal de informacion es aditivo