% 	ina.m
% 	Sodium channel
%
% 	modeled after Mahon and WB96 (with offset 7mV)
% 	using m,h and \infty formulation
% 	returns also steady-state values
%
%	$Revision:$
%
function [I_Na, dm, dh, m_inf, h_inf,tau_m, tau_h] = ina_WB96(V_m, m, h)

E_na = 55;		% mV
g_na = 35;		% mS/cm^2 

al_m = mylinexp(V_m, 0.1, -35+7, -10);
be_m = myexp(V_m, 4.0, -60+7, -18);
tau_m = 1/(al_m + be_m);

m_inf = al_m/(al_m + be_m);

al_h = myexp(V_m, 0.07, -58+7, -20);
be_h = mylog(V_m, 1, -28+7, -10);
h_inf = al_h/(al_h + be_h);
tau_h = 1/(al_h + be_h);

I_Na = g_na*(m_inf^3)*h*(V_m - E_na);

dm = al_m*(1-m) - be_m*m;
dh = 5*(al_h*(1-h) - be_h*h);
