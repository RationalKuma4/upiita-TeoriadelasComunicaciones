%
% LINMOD2
% A MATLAB script to generate AM, DSB-SC, QAM, SSB, SSB+C, VSB, and VSB+C
% signals, then demodulate them to get back the message signal.
% In this script 7 schemes of linear (amplitude) modulation are considered:
% AM, DSB-SC, QAM, SSB (or SSB-SC), SSB+C, VSB (or VSB-SC), and VSB+C.
% Two types of message signals are considered: random and sinusoid.
% DSB-SC, QAM, SSB, and VSB signals are demodulated coherently whereas
% AM, SSB+C, and VSB+C signals are demodulated non-coherently using 
% envelope detection.
% Two plots are given at the end: Figure(1) gives the modulated signal
% and Figure(2) gives both the demodulated signal and the true message signal.
% The demodulated and true message signals are plotted together for
% comparison purpose.
%
% Date: 09-25-2002
% Updated: 10-06-2002
%          10-18-2002
% ECE Dept., CU Boulder.
% Course: ECEN 4242
% Instructor: Belkacem Derras
%
Flag = menu('Choose modulation method','AM','DSB-SC','QAM','SSB','SSB+C','VSB','VSB+C');
N = 6000;    % number of data points. This number can be changed.
fc = 1e3;    % carrier frequency in Hz
fs = 1e4;    % sampling frequency in Hz
M = menu('Select type of message signal','Random', 'Sinusoid');
fm = 100;    % frequency (Hz) of message signal. Used for sinusoid case.
if M==1
   u = sqrt(2)*randn(N,1);       % random Gaussian noise
else
   u = cos(2*pi*fm*(0:N-1)/fs);  % sinusoid
end
u = u(:);
wcut = 0.05;    % normalized cutoff frequency for LPF
P = 5;          % order of LPF
if Flag == 1    % AM Modulation and Demodulation
   mu = input('Enter the modulation index 0<=mu<=1:  ');
   %
   % Modulation (generation of AM signal)
   %
   [B,A] = butter(P,wcut);    % low-pass Butterworth filter of order P
                            % and normalized cutoff frequency wcut.
   m = filter(B,A,u);       % filtering white noise to get correlated
                            % message signal with normalized bandwidth wcut.                         
   e = (ones(size(m)) + mu*m)';     % envelope of AM signal
   s = e.*cos(2*pi*fc*(0:N-1)/fs);  % AM signal
   figure(1)
   plot(s), grid
   xlabel('Time index')
   ylabel('Amplitude of AM signal')
   title('AM signal')           
   %
   % Demodulation (Envelope detection) of AM signal
   %
   y = filter(B,A,abs(s));  % applying low pass filter with normalized 
                       % cutoff frequency wcut, which represents
                       % the bandwidth of the message signal.
                       % the signal y represents the detected envelope
                       % which contains the message signal and a DC
                       % component.                    
                                           
   y = y - mean(y);    % filter the DC component
   y = 2*y/mu; 
   [gd,W] = grpdelay(B,A,N);
   Lgd = length(gd);
   gd = gd(1:Lgd-50);
   index = find(gd == max(gd));
   delay = round(mean(gd(1:index)));   % average delay introduced by the filter
   figure(2)
   plot(y(1+delay:end)), grid
   hold
   plot(m,'r')
   xlabel('Time index')
   ylabel('Amplitudes of demodulated signal and true message signal')
   title('Demodulated and true message signals for AM')           
elseif Flag == 2    % DSB-SC Modulation and Demodulation
   %
   % Modulation (generation) of DSB-SC signal
   %
   [B,A] = butter(P,wcut);    % low-pass Butterworth filter of order P
                            % and normalized cutoff frequency wcut.
   m = filter(B,A,u);       % filtering white noise to get correlated
                            % message signal with normalized bandwidth wcut.                        
   s = m'.*cos(2*pi*fc*(0:N-1)/fs);   % DSB-SC signal
   figure(1)
   plot(s), grid
   xlabel('Time index')
   ylabel('Amplitude of DSB-SC signal')
   title('DSB-SC signal')           
   %
   % Demodulation (Coherent detection) of DSB-SC signal
   %
   r = 2*s.*cos(2*pi*fc*(0:N-1)/fs);    % multiply received signal s
                                        % by the carrier at the receiver.
  
   y = filter(B,A,r);    % apply a low pass filter to the signal r.
                         % y represents the demodulated (message) signal
                         
   [gd,W] = grpdelay(B,A,N);
   Lgd = length(gd);
   gd = gd(1:Lgd-50);
   index = find(gd == max(gd)); 
   delay = round(mean(gd(1:index)));   % average delay introduced by the filter                   
   figure(2)
   plot(y(1+delay:end)),grid
   hold
   plot(m,'r')
   xlabel('Time index')
   ylabel('Amplitudes of demodulated and true message signals')
   title('Demodulated and true message signals for DSB-SC')                      
elseif Flag == 3   % QAM Modulation and Demodulation
	[B,A] = butter(P,wcut);   % low-pass Butterworth filter of order P
                            % and normalized cutoff frequency wcut.
    m1 = filter(B,A,u);     % filtering white noise to get correlated first
                            % message signal m1(t) with normalized bandwidth wcut. 
	if M==1
       u2 = sqrt(2)*randn(N,1);  % random Gaussian noise
    else
       u2 = cos(2*pi*2*fm*(0:N-1)/fs);   % tone generation with frequency 2fm.
    end
    u2 = u2(:);
	m2 = filter(B,A,u2);      % filtering white noise to get correlated second
                              % message signal m2(t) with normalized bandwidth wcut. 
    %
    % Modulation (generation of QAM signal)
    %
    
    % QAM signal 
    s = m1'.*cos(2*pi*fc*(0:N-1)/fs) + m2'.*sin(2*pi*fc*(0:N-1)/fs);
	figure(1)
    plot(s), grid
    xlabel('Time index')
    ylabel('Amplitude of QAM signal')
    title('QAM signal')           
    %
    % Demodulation (Coherent detection) of QAM signal
    %
    r1 = 2*s.*cos(2*pi*fc*(0:N-1)/fs);  % multiply received signal s
                                       % by the carrier cos(2*pi*fc*t) at the receiver.
    y1 = filter(B,A,r1);    % apply a low pass filter to the signal r1.
                            % y1 represents the demodulated (message) signal
    
    r2 = 2*s.*sin(2*pi*fc*(0:N-1)/fs);  % multiply received signal s
                                        % by the carrier sin(2*pi*fc*t) at the receiver.
  
    y2 = filter(B,A,r2);    % apply a low pass filter to the signal r2.
                            % y2 represents the demodulated (message) signal                    
    [gd,W] = grpdelay(B,A,N);
	Lgd = length(gd);
    gd = gd(1:Lgd-50);
    index = find(gd == max(gd));
    delay = round(mean(gd(1:index)));   % average delay introduced by the filter              
    figure(2)
    plot(y1(1+delay:end)),grid
    hold
	plot(m1,'r')
    xlabel('Time index')
    ylabel('Amplitudes of demodulated and true message signals')
    title('Demodulated and true message signals (m_1(t)) for QAM')
    figure(3)
    plot(y2(1+delay:end)),grid
    hold
	plot(m2,'r')
    xlabel('Time index')
    ylabel('Amplitudes of demodulated and true message signals')
    title('Demodulated and true message signals (m_2(t)) for QAM')
elseif Flag == 4      % SSB case
   Band = menu('Choose side band','USB','LSB');
   %
   % Modulation (generation) of SSB signal
   %
   [B,A] = butter(P,wcut);    % low-pass Butterworth filter of order P
                              % and normalized cutoff frequency wcut.
   m = filter(B,A,u);         % filtering white noise to get correlated
                              % message signal with normalized bandwidth wcut. 
   mhat = imag(hilbert(m));	  % Hilbet transform
   %
   % SSB signal generation
   %
   if Band == 1
      s = m'.*cos(2*pi*fc*(0:N-1)/fs) - mhat'.*sin(2*pi*fc*(0:N-1)/fs);   
   else
	  s = m'.*cos(2*pi*fc*(0:N-1)/fs) + mhat'.*sin(2*pi*fc*(0:N-1)/fs); 
   end	  
   figure(1)
   plot(s), grid
   xlabel('Time index')
   ylabel('Amplitude of SSB signal')
   title('SSB signal')           
   %
   % Demodulation (Coherent detection) of SSB signal
   %
   r = 2*s.*cos(2*pi*fc*(0:N-1)/fs);    % multiply received signal s
                                        % by the carrier at the receiver.
  
   y = filter(B,A,r);    % apply a low pass filter to the signal r.
                         % y represents the demodulated (message) signal                    
   [gd,W] = grpdelay(B,A,N);
   Lgd = length(gd);
   gd = gd(1:Lgd-50);
   index = find(gd == max(gd));
   delay = round(mean(gd(1:index)));   % average delay introduced by the filter                 
   figure(2)
   plot(y(1+delay:end)),grid
   hold
   plot(m,'r')
   xlabel('Time index')
   ylabel('Amplitudes of demodulated and true message signals')
   title('Demodulated and true message signals for SSB')                      
elseif Flag == 5     % SSB+C case
   Band = menu('Choose side band','USB','LSB');
   mu = input('Enter the modulation index 0<=mu<=1:  ');
   %
   % Modulation (generation) of SSB signal
   %
   [B,A] = butter(P,wcut);    % low-pass Butterworth filter of order P
                              % and normalized cutoff frequency wcut.
   m = filter(B,A,u);         % filtering white noise to get correlated
                              % message signal with normalized bandwidth wcut.  
   mhat = imag(hilbert(m));	  % Hilbet transform
   %
   % SSB+C signal generation
   %
   Ac = sqrt(max(abs(m))^2 + max(abs(mhat))^2)/mu;
   c = Ac*cos(2*pi*fc*(0:N-1)/fs);
   if Band == 0
      s = c + m'.*cos(2*pi*fc*(0:N-1)/fs) - mhat'.*sin(2*pi*fc*(0:N-1)/fs);   
   else
	  s = c + m'.*cos(2*pi*fc*(0:N-1)/fs) + mhat'.*sin(2*pi*fc*(0:N-1)/fs); 
   end	  
   figure(1)
   plot(s), grid
   xlabel('Time index')
   ylabel('Amplitude of SSB+C signal')
   title('SSB+C signal')           
   %
   % Demodulation (Non-coherent detection) of SSB+C signal
   %
   y = filter(B,A,abs(s));  % applying low pass filter with normalized 
                       % cutoff frequency wcut, which represents
                       % the bandwidth of the message signal.
                       % the signal y represents the detected envelope
                       % which contains the message signal and a DC
                       % component.                                                           
   y = y - mean(y);    % filter the DC component
   y = 2*y/mu;                  
   [gd,W] = grpdelay(B,A,N);
   Lgd = length(gd);
   gd = gd(1:Lgd-50);
   index = find(gd == max(gd));
   delay = round(mean(gd(1:index)));   % average delay introduced by the filter               
   figure(2)
   plot(y(1+delay:end)),grid
   hold
   plot(m,'r')
   xlabel('Time index')
   ylabel('Amplitudes of demodulated and true message signals')
   title('Demodulated and true message signals for SSB+C') 
elseif Flag == 6      % VSB case
   Band = menu('Choose side band','USB','LSB');
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
elseif Flag == 7    % VSB+C case
   Band = menu('Choose side band','USB','LSB');
   mu = input('Enter the modulation index 0<=mu<=1:  ');
   %
   % Modulation (generation) of VSB signal
   %
   [B,A] = butter(P,wcut);    % low-pass Butterworth filter of order P
                              % and normalized cutoff frequency wcut.
   m = filter(B,A,u);         % filtering white noise to get correlated
                              % message signal with normalized bandwidth wcut. 
   wc = 2*fc/fs;   % carrier frequency in normalized radians/second							  
   wv = 0.25*wcut;    % residual bandwidth
   NN = 512;
   nc = round(NN*wc);
   nv = round(NN*wv);
   ncut = round(NN*wcut);
   if Band == 0
      n0 = round(NN*(wc - wv));   % number of data points below wc - wv
      n1 = round(NN*(2*wv));      % number of data points within the bandwidth 
	                              % [wc-wv, wc+wv]
      vn1 = (0:n1-1)/n1;
	  vn1 = vn1(:);
      n2 = round(NN*(wcut-wv));    % number of data points within the bandwidth
	                               % [wc+wv,wc+wcut]
      n3 = NN - round(NN*(wc+wcut));  % number of data points above wc + wcut
	  Hi = [zeros(n0,1); vn1; ones(n2,1); zeros(n3,1)];
   else  
	  n0 = round(NN*(wc - wcut));   % number of data points below wc - wcut
	  n1 = round(NN*(wcut-wv));     % number of data points within the bandwidth
	                                % [wc-wcut,wc-wv]
      n2 = round(NN*(2*wv));        % number of data points within the bandwidth
	                                % [wc-wv, wc+wv]
      vn2 = 1 - (0:n2-1)/n2;
	  vn2 = vn2(:);
      n3 = NN - round(NN*(wc+wv));  % number of data points above wc + wv
	  Hi = [zeros(n0,1); ones(n1,1); vn2; zeros(n3,1)];
   end	                             
   hi = 2*real(ifft(Hi));   % impulse response of VSB filter
   hi = ifftshift(hi);
   hi = hi((NN/2)-100:(NN/2)+100);  % limit the impulse response to the interval where
   %                                  it has significant values.
   % VSB+C signal generation
   %
   phi = m'.*cos(2*pi*fc*(0:N-1)/fs);    % DSB-SC modulation
   s = filter(hi,[1],phi);               % VSB filtering
   s = s/max(abs(s));
   Ac = 1/mu;              % carrier amplitude
   c = Ac*cos(2*pi*fc*(0:N-1)/fs);       % carrier signal
   s = s + c;       % VSB signal plus carrier
   figure(1)
   plot(s), grid
   xlabel('Time index')
   ylabel('Amplitude of VSB+C signal')
   title('VSB+C signal')           
   %
   % Demodulation (Non-coherent detection) of VSB+C signal
   %
   y = filter(B,A,abs(s));  % applying low pass filter with normalized 
                       % cutoff frequency wcut, which represents
                       % the bandwidth of the message signal.
                       % the signal y represents the detected envelope
                       % which contains the message signal and a DC
                       % component.
   y = y - mean(y);    % filter the DC component
   S = xcov(y,m);
   index = find(S == max(S));
   delay = index - (length(S)+1)/2;  % obtain the dealy between y and m
   delay = abs(delay);
   y = y(1+delay:end); 
   y = y/max(abs(y));
   figure(2)
   plot(y),grid
   hold
   plot(m,'r')
   xlabel('Time index')
   ylabel('Amplitudes of demodulated and true message signals')
   title('Demodulated and true message signals for VSB+C') 
else	
   disp('Do nothing');
end