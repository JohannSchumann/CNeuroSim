% 	ih.m
%
% this channel definition is from Traub 2003
% and seems to contain Kir as well (????)
% very strong effect, shifts V_rest to almost -60 mV
%
% hyperpol-activated channel from Traub 2003
%
%	$Revision:$
%
function [I_h, dm, m_inf] = ih(V_m, m)

E_h = -35;		% mV
g_h = 0.25;		% mS/cm^2

I_h = g_h*m*(V_m - E_h);

m_inf = mylog(V_m, 1, -75.0, 5.5);
tau_m = 1 / ( exp( -14.6 - 0.086 * V_m ) + exp( -1.87 + 0.07 * V_m ) );


dm = (m_inf - m)/tau_m;
