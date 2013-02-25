% 	Potassium channel
%
% 	modeled after Mahon and WB96
% 	using n and alpha, beta formulation
% 	returns also steady-state value
%
%	$Revision:$
%
function [I_K, dn, n_inf ] = ik(V_m, n)

E_K = -90;	% mV
g_K = 6;	% mS/cm^2 

	%
al_n = mylinexp(V_m, 0.01, -34, -10);
be_n = myexp(V_m, 0.125, -44, -80);
n_inf = al_n/(al_n + be_n);

dn = al_n*(1-n) - be_n*n;

I_K = g_K * (n^4)*(V_m - E_K);

