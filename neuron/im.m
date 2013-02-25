% 	im.m
% 	"M" channel (K+) from Traub 2003
%
%	$Revision:$
%
function [I_KM, dm, m_inf] = im(V_m, m)

E_M = -85;		% mV
g_M = 0.2;		% mS/cm^2



al_m = mylog(V_m, 0.02, -20, -5);
be_m = myexp(V_m, 0.01, -43, -18);

m_inf = al_m/(al_m + be_m);

I_KM = g_M*m*(V_m - E_M);

dm = al_m*(1-m) - be_m*m;
