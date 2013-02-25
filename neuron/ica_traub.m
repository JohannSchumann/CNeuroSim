% 
% ical.m
% Calcium channel from Traubetal 2003
%
%
%	$Revision:$
%
function [I_CaL, dm, dh, m_inf, h_inf] = ical_traub(V_m, m, h)

E_CaL = 125;	% mV
g_CaL = 0.1;	% mS/cm^2

al_m = mylog(V_m, 1.6, 5, -0.072);	
be_m = mylinexp(V_m, -0.02, -8.9, 5);

m_inf = al_m/(al_m + be_m);

h_inf = 99;

I_CaL = g_CaL*(m^2)*(V_m - E_CaL);

dm = al_m*(1-m) - be_m*m;
dh = 0;
