% ical.m
% Calcium channel
% from: model6/ical_tsubo.m
%
% modeled after Tsubo and Gruber (g_CaL and offset -20mV)
% with offset 7mV to match Mahonetal2000
% using m,h and alpha, beta formulation
% returns also steady-state values
%
%	$Revision:$
%
function [I_CaL, dm, dh, m_inf, h_inf] = ical_tsubo(V_m, m, h)

shift=0;
%shift=20;

E_CaL = 140;	% mV
%g_CaL = 0.01;	% mS/cm^2
g_CaL = 0.1;	% mS/cm^2 [Gruber]

al_m = mylinexp(V_m, 0.055, -27+7-shift, -3.8);	% type 3 [Tsubo]
be_m = myexp(V_m, 0.94, -75+7-shift, -17);		% type 1

m_inf = al_m/(al_m + be_m);

al_h = myexp(V_m, 0.000457, -13+7-shift, -50);	% type 1
be_h = mylog(V_m, 0.0065, -15+7-shift, -28);		% type 2
h_inf = al_h/(al_h + be_h);

I_CaL = g_CaL*(m^2)*h*(V_m - E_CaL);

dm = al_m*(1-m) - be_m*m;
dh = al_h*(1-h) - be_h*h;
