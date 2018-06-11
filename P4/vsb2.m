close all;
clear all;
clc;

t0=0.15;
fc=250;
ts=0.0001;
fs=1/ts;
t=0:ts:2*t0/3;
w=(-1000:1000)*2*pi;
N = 6000;

c=cos(2*pi*fc*t);
m=1.*(0<=t & t<t0/3)-2.*(t0/3<=t & t<2*t0/3)+0;

%%
Band = 1;
wcut = 0.05;    % normalized cutoff frequency for LPF
P = 5;          % order of LPF
u = m(:);
%
% Modulation (generation) of VSB signal
%
[B,A] = butter(P,wcut);    % low-pass Butterworth filter of order P
                          % and normalized cutoff frequency wcut.
m = filter(B,A,u);         % filtering white noise to get correlated
                          % message signal with normalized bandwidth wcut. 
wc = 2*fc/fs;      % carrier frequency in normalized radians/second							  
wv = 0.25*wcut;    % normalized residual bandwidth
NN = 512;          % number of frequency response samples of VSB filter
if Band == 0
  n0 = round(NN*(wc - wv));  % number of data points below wc - wv
  n1 = round(NN*(2*wv));     % number of data points within the bandwidth 
                             % [wc-wv, wc+wv]
  vn1 = (0:n1-1)/n1;         % samples of the ramp
  vn1 = vn1(:);
  n2 = round(NN*(wcut-wv));  % number of data points within the bandwidth
                             % [wc+wv,wc+wcut]
  n3 = NN - round(NN*(wc+wcut));  % number of data points above wc + wcut
  Hi = [zeros(n0,1); vn1; ones(n2,1); zeros(n3,1)];   % frequency response
                                                      % of VSB filter
else  
  n0 = round(NN*(wc-wcut));   % number of data points below wc - wcut
  n1 = round(NN*(wcut-wv));   % number of data points within the bandwidth
                              % [wc-wcut, wc-wv]
  n2 = round(NN*(2*wv));      % number of data points within the bandwidth
                              % [wc-wv, wc+wv]
  vn2 = 1 - (0:n2-1)/n2;
  vn2 = vn2(:);
  n3 = NN - round(NN*(wc+wv));  % number of data points above wc + wv
  Hi = [zeros(n0,1); ones(n1,1); vn2; zeros(n3,1)];
end	   


hi = 2*real(ifft(Hi));         % impulse response of VSB filter
hi = ifftshift(hi);            % shift hi to have symmetrical form
hi = hi((NN/2)-100:(NN/2)+100);
%
% VSB signal generation
%
phi = m'.*cos(2*pi*fc*(0:N-1)/fs);
s = filter(hi,[1],phi);
figure(1)
plot(s), grid
xlabel('Time index')
ylabel('Amplitude of VSB signal')
title('VSB signal')           
%
% Demodulation (Coherent detection) of VSB signal
%
r = 2*s.*cos(2*pi*fc*(0:N-1)/fs);    % multiply received signal s
                                    % by the carrier at the receiver.
ncut = round(NN*wcut);    % number of data points within the baseband wcut
nv = round(NN*wv);        % number of data points within the residual bandwidth
% frequency response of lowpass filter.                            
H0 = [2*ones(nv,1); ones(ncut-nv,1); zeros(NN-ncut,1)];  
h0 = 2*real(ifft(H0));    % impulse response of lowpass filter H0
h0 = ifftshift(h0);
h0 = h0((NN/2)-100:(NN/2)+100);   % limit the impulse response to the interval where
                         % it has significant values.
y = filter(h0,[1],r);     % apply a low pass filter to the signal r.
                         % y represents the demodulated (message) signal						
y = y/max(abs(y));                      
S = xcov(y,m);
index = find(S == max(S));
delay = index - (length(S)+1)/2;
delay = abs(delay);
figure(2)
plot(y(1+delay:end)),grid
hold
plot(m,'r')
xlabel('Time index')
ylabel('Amplitudes of demodulated and true message signals')
title('Demodulated and true message signals for VSB')