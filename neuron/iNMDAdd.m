%
% simple model of NMDA
% integration of t_nmda
%
%	$Revision:$
%

function [I, d1, d2, NMDA] = iNMDAdd(V_m, S1, S2, I_S, t)

V_block = 10;

%
d1 = - (1/120)*S1 - (1/20)*I_S;
d2 = - (1/12)*S2 - (1/20)*I_S;
%
NMDA = (-(S1-S2));

V_spom = 1/(1+0.28*1.2*exp(-0.062*(V_m - V_block)));

I = V_spom* NMDA;
%I = mylog(V_m, 5.07, -25, -0.088)*(S1-S2);
