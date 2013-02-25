
%-------------------------------------------------------------
% $Revision:$
%
% from TYPES/exp_conduct/run_syn_response_01X
% run script for single-input
%	run_sr4:   like run_sr3 with pre-loading of initial state
%-------------------------------------------------------------

fn=sprintf('%s.dat', sim.FN);
fn_inp=sprintf('%s_inp.dat', sim.FN_INP);

if (sim.do_sim == 0),
	load(fn, '-mat');
else 

%	ts = 1;

%	sim.N_upd = N_upd;
%	sim.N_nn = N_nn;
%	sim.T_upd = T_upd;
%	sim.ts = ts;

	%
	% neuron parameters
	%
	continued = 0;

	init_nn = sprintf('init_%s',sim.neuron);
	[sim, nn_params_baseline, l_param, dummy] = ...
		feval(init_nn, sim, nn_mu_params);


	all_NM = zeros(sim.N_upd) + 1;	% NM values for each update cycle

	%
	% space alloc.
	%
	all_nn_params = zeros(sim.N_upd+1, sim.N_nn, l_param);
	
	%
	% initialize instrumentation
	%
	sim.instrument.saved_act = zeros(sim.N_upd,sim.N_nn);
	sim.instrument.allvm     = zeros(sim.N_upd,sim.N_nn,sim.T_upd);
	sim.instrument.allconduct = zeros(sim.N_upd,sim.N_nn,sim.T_upd);
	sim.instrument.spiketrain = zeros(sim.N_upd,sim.N_nn,sim.T_upd);
			
	
	%
	% set initial starting nn parameters
	%
	for i=1:sim.N_nn,
		all_nn_params(1,i,:) = nn_params_baseline;
		all_nn_params(1,i,21:20+sim.N_params) = nn_mu_params(i,:);
	end;

	%
	% generate the inputs
	%
	if (sim.do_gen_inputs == 0),
		load(fn_inp, '-mat');
	else 
	  fprintf('Generating input signal(s)...\n');
  	  all_nn_inputs(1,:) = gen_nn_inputs(sim, input_params)';
	  if (~exist('input_params_inh')),
		all_nn_inputs(2,:) = zeros(1,sim.sim.T_upd+input_params.start);
	  else
	        all_nn_inputs(2,:) = gen_nn_inputs(sim, input_params_inh)';
	  end;
%	  if (sim.do_analyze_inp),
%		inp_analysis(-all_nn_inputs, input_params, sim);
%		xxxx = input('press -1 to abort>');
%		if (xxxx == -1),
%			return;
%		end;
%          end;

	  if (sim.do_save_inputs > 0),
	     if (~exist('input_params_inh')),
		save(fn_inp, 'all_nn_inputs', 'input_params');
	     else
		save(fn_inp, 'all_nn_inputs', 'input_params','input_params_inh');
	    end;
	  end;
	end;

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%
	% simulation loop
	%
	fprintf('Starting simulation loop...\n');
	for i_upd = 1:sim.N_upd

		%
		% set NM parameter for that update cycle
		% (global for all neurons)
		%
		NM = all_NM(i_upd);
		
		%
		% get the inputs for each neuron for this
		% update cycle
		%
		%
		% same inputs for all neurons
		%
		for nn=1:sim.N_nn,

			%
			%  prepare the inputs
			%
%			nn_inputs(1,:) = all_nn_inputs_excit;
%			nn_inputs(2,:) = all_nn_inputs_inh;
			nn_inputs = all_nn_inputs;

			%
			% get current neuron parameters
			% continued == 0: restart with fresh neuron
			%
			nn_params = reshape(all_nn_params(i_upd,nn,:),1,20+sim.N_params);
			nn_params(1:20) = nn_params_baseline(1:20);

if (isfield(sim, 'nn_start_val')),
	nn_params(14) = sim.nn_start_val(nn,14);
end;
	
			%
			% run neuron for t_run
			%
			[nn_params, vm, conduct, I_Channel] = ...
				run_neuron(nn_params, NM, nn_inputs,sim);
	
			%
			% evaluate activity
			%
			[spi, spt, act] = calc_spiketrain(vm, sim);
			sim.instrument.allvm(i_upd,nn,:) = vm;
			sim.instrument.allconduct(i_upd,nn,:) = conduct;
			sim.instrument.spiketrain(i_upd,nn,:) = spt;

			%
			% record activity of specific channels
			%
			sim.instrument.I_Channels(i_upd,nn) = I_Channel;
			
			iisi = [spi sim.T_upd] - [0 spi];

			if (length(iisi) <= 2),
				m_isi = -99;
				s_isi = -99;
			else
				m_isi = mean(iisi(2:end-1));
				s_isi = std(iisi(2:end-1));
			end;

			sim.instrument.m_isi(i_upd,nn) = m_isi;
			sim.instrument.s_isi(i_upd,nn) = s_isi;

		mean_inp = mean(nn_inputs(1,:) + nn_inputs(2,:),2);
		mean_inp_excit = mean(nn_inputs(1,:));
		mean_inp_inh   = mean(nn_inputs(2,:));
		if (strcmp(sim.neuron,'neuron_nmda3')),
		  mean_inp_NMDA  = mean(sim.instrument.I_Channels(nn).I_NMDA);
		  mean_inp_INJ = ...
		    all_nn_params(1,nn,20+14)*mean_inp_excit + ...
		    all_nn_params(1,nn,20+16)*mean_inp_inh + ...
		    all_nn_params(1,nn,20+12)*mean_inp_NMDA;
		else
		  mean_inp_NMDA  = 0;
		  mean_inp_INJ = ...
		    all_nn_params(1,nn,20+5)*mean_inp_excit + ...
		    all_nn_params(1,nn,20+6)*mean_inp_inh;
		end;

		if (sim.nA_units == 1),
			mean_inp = mean_inp * sim.nA;
			mean_inp_excit = mean_inp_excit * sim.nA;
			mean_inp_inh= mean_inp_inh* sim.nA;
			mean_inp_NMDA = mean_inp_NMDA * sim.nA;
			mean_inp_INJ = mean_inp_INJ * sim.nA;
			unit='nA';
		else
			unit='muAcm^-2';
		end;
  fprintf('N %d act %d ISI=%.1f (%.2f) |I_s|=%.3f%s |I_S_exc|=%.3f%s |I_S_inh|=%.3f%s |I_S_NMDA|=%.3f%s |I_inj|=%.3f%s\n',...
		nn, act, ...
		m_isi, s_isi, ...
		abs(mean_inp),unit,...
		abs(mean_inp_excit),unit,...
		abs(mean_inp_inh),unit,...
		abs(mean_inp_NMDA),unit,...
		abs(mean_inp_INJ),unit...
		);
		
	
			all_nn_params(i_upd+1,nn,:) = nn_params;
	
	
			end;

	end;
	save(fn);

end;
