% 	Kir channel
%
% 	modeled after Mahon
% 	returns also steady-state value
%
%	$Revision:$
%
function [I_Kir, dm, m_inf ] = ikir(V_m, m)

E_Kir = -90;	% mV
g_Kir = 0.15;	% mS/cm^2

m_inf = mylog(V_m, 1, -100, 10);

% instant activation 
dm = 0;
I_Kir = g_Kir*m_inf*(V_m - E_Kir);

