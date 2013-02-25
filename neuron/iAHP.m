% 	iAHP.m
% 	Calcium gated potassium channel
% 	from: Traub 2003
%
%
%	$Revision:$
%
function [I_AHP, dm, m_inf] = iAHP(V_m, m, Ca_i)

E_AHP = -90;	% mV in concordance with our model
g_AHP = 0.1;	% mS/cm^2

be_m = 0.01;

al_m = 1e-3*Ca_i;
be_m = 0.1;


traub=0;
if (traub == 1),
	al_m = min(0.01, 1e-4*Ca_i);
	be_m = 0.01;
	g_AHP = 0.1;
end;

dm = al_m*(1-m) - be_m*m;
m_inf = al_m/(al_m + be_m);

I_AHP = g_AHP*m*(V_m - E_AHP);

