function [F] = EspectroNumerico(f,t,ts,w)
% Calculo numerico de la integral para el espectro
%   f=Funcion a integrar.
%   t=Intervalo de tiempo.
%   ts=Diferencial.
%   w=Intervalo de omega
    F=0;
    n=0;
    for tt=t
        n=n+1;
        F=F+f(n)*exp(-1i*w*tt)*ts;
    end
end

