clear all;
close all;

%% 1a)
F=239;
T=1/F;
t=linspace(0,3*T);
x=@(t) 3*cos(2*pi*F*t);
figure(1);
plot(t, x(t))

%% 1b)
F=7/44;
T=1/F;
t=linspace(0,5*T);
x=@(t) 2*sin(2*pi*F*t);
figure(2);
plot(t, x(t))

%% 1c)
Tp=1/25;
t=linspace(0,2*Tp);
x=4*cos(2*pi*175*t)+7*sin(2*pi*375*t);
figure(3);
plot(t, x);

%% 2a)

%% 2b)

%% 2c)
F=1/2*pi;
T=1/F;
t=linspace(0,T,100);
x=@(t) power(sin(2*pi*F*t),5);
figure(4);
plot(t, x(t))

X=fftshift(fft(x(t)),100);
figure(5);
stem(t, abs(X));

figure(6);
stem(t, X);

%% 3a)

%% 3b)

%% 3c)

%% 4a)

%% 4b)
t=27:0.01:30;
x=exp(3*abs(t));
figure(7);
plot(t,x);

X=fftshift(fft(x),50);
figure(5);
stem(t, abs(X));

figure(6);
stem(t, X);

%% 5a)
fun = @(x) sin(x)./x;
%fun = @(x) exp(-x.^2).*log(x).^2;
q = integral(fun,0-Inf,Inf);



