% 	inap.m
% 	NaP Sodium channel
%
% 	with parameters from [Traub2003] Neuron-model
%
%	$Revision:$
%
function [I_NaP, dm, m_inf] = inap(V_m, m)

E_NaP = 50;		% mV
g_NaP = 0.11;		% mS/cm^2

I_NaP = g_NaP*m*(V_m - E_NaP);

m_inf = mylog(V_m, 1, 48, -10);
if (V_m < -40),
	tau_m = 0.025 + 0.14*exp((V_m + 40)/10);
else
	tau_m = 0.02 + 0.145*exp((V_m + 40)/(-10));
end;
dm = (m_inf - m)/tau_m;
