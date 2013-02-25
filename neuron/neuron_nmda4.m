% 	neuron_nmda4.m
% 	like neuron_nmda3 
% 	but uses nmda_in (instead of I_NMDA) to control Cai
%
%	$Revision:$
%
function dot_state = neuron_nmda3(t, state)

global I_S;
global Ts;
global par;

ct = floor(t/Ts);

C_m = 1;

V_M = state(1);
dot_state=zeros(length(state),1);

I_L = ileak(V_M);
[I_Na, dot_state(2), dot_state(3)] = ina(V_M, state(2), state(3));
[I_K, dot_state(4)] = ik(V_M, state(4));

%%[I_CaL, dot_state(5), dot_state(6)] = ical(V_M, state(5), state(6));
[I_CaL, dot_state(5), dot_state(6)] = ica_traub(V_M, state(5), state(6));

[I_KAs, dot_state(7), dot_state(8)] = ikas(V_M, state(7), state(8));

[I_NaS, dot_state(9)] = inap(V_M, state(9));
[I_Kir, dot_state(10)] = ikir(V_M, state(10));
[I_Kaf, dot_state(11), dot_state(12)] = ikaf(V_M, state(11), state(12));


	% V_M, m, Cai
[I_AHP, dot_state(13)] = iAHP(V_M, state(13), par(11)*state(14));

	% NMDA
[I_NMDA, dot_state(16), dot_state(17), nmda_in] = ...
	iNMDAdd(V_M, state(16), state(17), I_S, ct);

	% Cai:
%dot_state(14) = cai(V_M, state(14), par(2)*I_CaL, par(10)*nmda_in);
dot_state(14) = cai(V_M, state(14), par(2)*I_CaL, par(10)*I_NMDA);


[I_M, dot_state(15)] = im(V_M, state(15));

[I_H, dot_state(18)] = ih(V_M, state(18));





dot_state(1) = -(1/C_m)*...
 (par(1)*I_K + par(2)*I_CaL + par(3)*I_KAs + ...
  par(4)*I_Na + par(5)*I_NaS + par(6)*I_Kaf + par(7)*I_Kir + ...
  par(8)*I_AHP +  par(9)*I_M + par(12)*I_NMDA + ...
  par(13)*I_H + ...
  I_L + I_S(1,ct) + I_S(2,ct));
