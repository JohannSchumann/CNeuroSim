function x = input_markov(input_params, sim)

x= zeros(sim.T_upd+input_params.start,1);

cx = input_params.markov_sigma * randn;
for i=1:sim.T_upd+input_params.start,
	x(i) = cx * input_params.markov_ampl;
	cx = cx * exp(-input_params.markov_tau) + ...
                  input_params.markov_sigma * randn;
	end;
