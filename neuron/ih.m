% 	ih.m
% 	I_h channel modeled after 
% http://senselab.med.yale.edu/senselab/modeldb/ShowModel.asp?model=82364
% after Magee'98
%
%	$Revision:$

function [I_h, dm, m_inf] = ih(V_m, m)

E_h = -37;		% mV
g_h = 0.1;		% mS/cm^2

I_h = g_h*m*(V_m - E_h);

	% 7mV offset
	% orig: -81[mV]
m_inf = mylog(V_m, 1, -88, 8);

	% 7mV offset
	% orig: -75mV
al = exp(0.0832 * (V_m +82));
	% 7mV offset
be = exp(0.033 * (V_m +82));

tau_m = be /(0.011*(1+al));

dm = (m_inf - m)/tau_m;
