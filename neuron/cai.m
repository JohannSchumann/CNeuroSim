% 	Cai.m
% 	internal Calcium 
%
%
%	$Revision:$
%
function dCa_i = cai(V_M, Ca_i, I_CaL, I_S)

phi_Ca_i = 52/2;


beta_Ca_i = 1/20;     % Traub 2003: 20 - 50ms

gamma_Ca_i = 0.7;

dCa_i = - phi_Ca_i * I_CaL - beta_Ca_i * Ca_i - gamma_Ca_i * I_S;
