% 	Af channel
%
% 	modeled after Mahon2000
% 	using n and alpha, beta formulation
% 	returns also steady-state value
%
%	$Revision:$
%
function [I_KAf, dm, dh, m_inf, h_inf] = ikaf(V_m, m, h)

E_KAf = -73;		% mV
g_KAf = 0.09;		% mS/cm^2 Mahon

I_KAf = g_KAf*m*h*(V_m - E_KAf);

m_inf = mylog(V_m, 1, -33.1, -7.5);
tau_m = 1.0;
dm = (m_inf - m)/tau_m;

h_inf = mylog(V_m, 1, -70.4, 7.6);
tau_h = 25.0;
dh = (h_inf - h)/tau_h;


