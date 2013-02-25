

sim.N_upd = 1;


	%
	% number of external input sources
	%
sim.net.N_ext_source = 1;

M=sim.net.N_ext_source  + sim.N_nn;

sim.net.G_AMPA = zeros(M, sim.N_nn);
sim.net.G_GABA = zeros(M, sim.N_nn);
sim.net.G_NMDA = zeros(M, sim.N_nn);

	%
	% default: route nn_inputs to all neurons
	%
for i=1:sim.N_nn,
	for j=1:sim.net.N_ext_source,
		sim.net.G_AMPA(sim.N_nn + j, i) = 1;
		sim.net.G_GABA(sim.N_nn + j, i) = 1;
		sim.net.G_NMDA(sim.N_nn + j, i) = 1;
		end;
	end;


sim.net.delay_AMPA = zeros(M,1);
sim.net.delay_GABA = zeros(M,1);
sim.net.delay_NMDA = zeros(M,1);

	%
	% due to the sign convention in the AHP models,
	% excitatory current has a *negative* sign
	% thus, neuron->neuron strength need to be negative
	% input -> neuron strength is positive
	% 
sim.net.strength_AMPA = -1*ones(M,1);
sim.net.strength_AMPA(M) = 1;
sim.net.strength_GABA = -1*ones(M,1);
sim.net.strength_GABA(M) = 1;
sim.net.strength_NMDA = -1*ones(M,1);
sim.net.strength_NMDA(M) = 1;


	%
	% time intervals when external input is active
	%
sim.net.ext_input_intervals = 1:sim.T_upd;
