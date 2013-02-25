%
%	run a vector of neurons for one sim.Ts time step
%
%	NOTES:
%	* currently ONLY for neuron_izh
%	* should be improved at least for izh to run  in a vectorized
%	  form
%
%	$Revision:$

function [nn_params_new] = run_neuron_vector(sim, I_presyn, nn_params)

%--------------------------------
% globals needed to pass parameters
% to the neuron.m function
%
global I_S;
global Ts;
global par;


Ts = sim.ts;


for i = 1:sim.N_nn,
	I_S = I_presyn(:,i);
	par = nn_params(i,21:20+sim.N_params);
	nn_params_new(i,:) = feval(sim.neuron, 1, nn_params(i,:));
	end;

