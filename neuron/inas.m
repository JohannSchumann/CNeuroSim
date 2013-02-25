% 	inas.m
% 	NaP Sodium channel
%
% 	modeled after Mahon2000
% 	using m formulation
% 	returns also steady-state values
%
%	$Revision:$
%
function [I_NaS, dm, m_inf] = inas(V_m, m)

E_NaS = 40;		% mV
g_NaS = 0.11;		% mS/cm^2

I_NaS = g_NaS*m*(V_m - E_NaS);

m_inf = mylog(V_m, 1, -16.0, -9.4);
tau_m = myact(V_m, 637.8, -33.5, 26.3);
dm = (m_inf - m)/tau_m;
