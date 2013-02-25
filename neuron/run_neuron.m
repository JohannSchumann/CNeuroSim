% run_neuron.m
%
% from run_neuron
% With EXCIT + INHIB inputs = nn_inputs(1,:), nn_inputs(2,:)
%
% run neuron with given statevector (parameters/states) for a given amount 
% of time
% (specified in sim) on inputs "nn_inputs"
% returns: new state vector nn_params
%
%	$Revision:$
%

function [nn_params, vm, conduct, I_channels] = run_neuron(nn_params, NM, nn_inputs, sim)


vm = zeros(1, sim.T_upd*sim.ts);

conduct = zeros(1, sim.T_upd*sim.ts);

%--------------------------------
% globals needed to pass parameters
% to the neuron.m function
%
global I_S;
global Ts;
global par;

t=2*sim.ts;

Ts = sim.ts;


%
% extract current channel states form state vector
%
V0 = reshape(nn_params(1:sim.N_states),1,sim.N_states);

%
% get current mu parameters into global vector
%
par = NM * nn_params(21:20+sim.N_params);

%
% get inputs into global vector
%
I_S = nn_inputs;

%
% do the simulation
% NOTE:
%	neuron requires current-I_syn input
%	if nn_inputs are conductances: convert before doing integration
%
for i=1:sim.T_upd-1,
	if (sim.input_units == 'conductance'),
		I_S(:,floor(t/Ts)) = nn_inputs(:,floor(t/Ts)) * (V0(1) - 0);
		end;
	dV_m = V0(1);
	if (strcmp(sim.integration, 'ode')),
		[time,V1] = ode45(sim.neuron,[t-Ts t], V0);
		V0 = V1(length(time),:)';
	else
		V0 = feval(sim.neuron, t, V0);
	end;
	V_m = V0(1);
	vm(i) = V_m;
	dV_m = V_m - dV_m;

	%
	% calculate the currents if necessary
	%
	if (sim.get_channels),
		%-----------------------------------
%%		conduct(i) = neuron_conduct(t,V0);
		%-----------------------------------
		I_channels.I_K(i)   = par(1) * ik(V_m, V0(4));
		I_channels.I_CaL(i) = par(2) * ica_traub(V_m, V0(5), V0(6));
		I_channels.I_KAs(i) = par(3) * ikas(V_m, V0(7), V0(8));
		I_channels.I_Na(i)  = par(4) * ina(V_m, V0(2), V0(3));
		I_channels.I_NaS(i) = par(5) * inas(V_m, V0(9));
		I_channels.I_Kaf(i) = par(6) * ikaf(V_m, V0(11), V0(12));
		I_channels.I_Kir(i) = par(7) * ikir(V_m, V0(10));
		I_channels.I_AHP(i) = par(8) * ...
				iAHP(V_m, V0(13), par(11)*V0(14));
		I_channels.Cai(i)   = V0(14);
		I_channels.I_M(i)   = par(9) * im(V_m, V0(15));
		I_channels.I_H(i)   = par(13) * ih(V_m, V0(18));
		I_channels.I_NMDA(i)= par(12) * iNMDAdd(V_m, V0(16), V0(17), ...
				par(15)*I_S(1,i), i);
		I_channels.I_INJ(i)= I_channels.I_NMDA(i) + ...
				par(14)*I_S(1,i) + ...
				par(16)*I_S(2,i);
		I_channels.dV_m(i)    = dV_m;
%		I_channels.I_new(i)    = zeros(1, sim.T_upd*sim.ts);

		%-----------------------------------
	 else
		I_channels=0;
		end;
	t = t + sim.ts;
end;
%
% update state vector by new channel states
%
nn_params(1:sim.N_states) = V0;
