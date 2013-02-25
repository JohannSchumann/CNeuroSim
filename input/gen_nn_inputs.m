%
% create an overlay of various kinds of inputs
%
% usable for excit and inhib. input
%
function inp = gen_nn_inputs(sim, input_params)

	%
	% beef up the input_params structure
	% (compatibility with older versions)
	%
if (~isfield(input_params, 'I0_p')),

	input_params.I0_p = 0.1;  	%nA
	input_params.tau_p = 2.5;	% ms;
	input_params.I0_n = -0.033;  	%nA
	input_params.tau_n = 3;		% ms;

	end;

if (~isfield(input_params, 'corr_factor')),
	input_params.corr_factor = 0;
	input_params.W_size = 8;
	end;


	%
	% generate correlated or uncorrelated
	% synaptic inputs into the "inp" structure.
	% if none selected (g0==0), make a zeros-vector
	%

if (input_params.g0 == 0),
	inp = zeros(sim.T_upd+input_params.start,1);
else
	if (input_params.corr_factor > 0),
		inp = input_params.g0 * ...
			generate_inputs_corr(...
			  sim.T_upd+input_params.start, ...
			  sim,...
			  input_params);
	else
    		inp= ...
      		    input_params.g0 * ...
                       inp_poisson(input_params, ...
			sim.T_upd+input_params.start, ...
			input_params.Mp, ...
			input_params.Mn, ...
			input_params.lambdap, ...
			input_params.lambdan, ...
			1);
        end;
end;

if (input_params.sin_ampl ~= 0),
  inp = inp + ...
                        input_sin(sim.T_upd+input_params.start,input_params.sin_freq, input_params.sin_width, input_params.sin_ampl, input_params);
end;
	
if (input_params.dc ~= 0),
  inp(input_params.start + [input_params.dc_start:input_params.dc_stop]) = inp(input_params.start + [input_params.dc_start:input_params.dc_stop]) + input_params.dc;
end;

	%
	% add noise
	%
inp = inp + ...
    input_params.eta*randn(sim.T_upd+input_params.start,1);

if (input_params.ss_ampl ~= 0),
  inp = inp + input_ss(input_params, sim);
end;

if (input_params.markov_ampl ~= 0),
  inp = inp + input_markov(input_params, sim);
end;
