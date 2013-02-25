% 	Slow Potassium channel
%
% 	modeled after Mahon2000
%	Note: in tau_h, mahon2000 has 2930 instead of 293.0
%
% using n and alpha, beta formulation
% returns also steady-state value
%
%	$Revision:$
%
function [I_KAs, dm, dh, m_inf, h_inf] = ikas(V_m, m, h)

E_As = -85;		% mV
g_As = 0.32;		% mS/cm^2


I_KAs = g_As*m*h*(V_m - E_As);

m_inf = mylog(V_m, 1, -25.6, -13.3);
tau_m = myact(V_m, 131.4, -37.4, 27.3);
dm = (m_inf - m)/tau_m;

h_inf = mylog(V_m, 1, -78.8, 10.4);
tau_h = 179.0 + 293.0*exp(-((V_m + 38.2)/28)^2) * ((V_m + 38.2)/28);
dh = (h_inf - h)/tau_h;


