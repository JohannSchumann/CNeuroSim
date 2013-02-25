%-------------------------------------------------------------
% $Id: run_sim_net.m,v 1.2 2007/10/11 20:16:41 schumann Exp $
%
% run-script for networked neurons
%	based on: run_sr4
%-------------------------------------------------------------

fn=sprintf('%s.dat', sim.FN);
fn_inp=sprintf('%s_inp.dat', sim.FN_INP);

if (sim.do_sim == 0),
	load(fn, '-mat');
else 

		%
		% start with fresh neurons
		%
	continued = 0;
	init_nn = sprintf('init_%s',sim.neuron);

       for i=1:sim.N_nn,
	    [sim, nn_params_baseline, l_param, dummy] = ...
			feval(init_nn, sim, nn_mu_params(i,:));
	    nn_params(i,:) = nn_params_baseline;
	    nn_params(i,21:20+sim.N_params) = nn_mu_params(i,:);
            end;
	    baseline_status = nn_params(:,1:20);

		%
		% initialize instrumentation
		%
	sim.instrument.saved_act = zeros(sim.N_upd,sim.N_nn);
	sim.instrument.allvm     = zeros(sim.N_upd,sim.N_nn,sim.T_upd);
	sim.instrument.allconduct = zeros(sim.N_upd,sim.N_nn,sim.T_upd);
	sim.instrument.spiketrain = zeros(sim.N_upd,sim.N_nn,sim.T_upd);

	net_AMPA = zeros(1,sim.N_nn + sim.net.N_ext_source);
	net_GABA = zeros(1,sim.N_nn + sim.net.N_ext_source);
	net_NMDA = zeros(1,sim.N_nn + sim.net.N_ext_source);

	%
	% generate the inputs
	%
	% NOTE: works for sim.net.N_ext_source = 1 ONLY
	%
	if (sim.do_gen_inputs == 0),
		load(fn_inp, '-mat');
	else 
	
	  if (sim.net.N_ext_source >1),
		fprintf('multiple input source NYI\n');
		return;
		end;
	  
  	  all_nn_inputs(1,:) = gen_nn_inputs(sim, input_params)';
	  if (~exist('input_params_inh')),
		all_nn_inputs(2,:) = zeros(1,sim.sim.T_upd+input_params.start);
	  else
	        all_nn_inputs(2,:) = gen_nn_inputs(sim, input_params_inh)';
	  end;

		%
		% save the inputs if necessary
		%
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
	% big simulation loop
	%
%	t_cpu = tic;
	for i_upd = 1:sim.N_upd

		%
		% get the inputs for each neuron for this
		% update cycle
		%
		% NOTE: currently, inputs must be the same for
		% each update cycle.
		% Otherwise: save sim data and start with a reloaded
		% version
		%
	    ext_inputs = all_nn_inputs;
	    nn_inputs = all_nn_inputs;

		%
		% get current neuron parameters
		% continued == 0: restart with fresh neuron
		%
	if ((continued == 0) && (i_upd > 1)),
	    nn_params(:,1:20) = baseline_status;
	    end;

	%===========================================
	% inner loop
	%===========================================
        fprintf('starting simulation loop\n');
	tic;
        recent_act=0;
	recent_act_cntr=zeros(1,sim.N_nn);
	for t=1:sim.T_upd,

		%
		% prepare the synaptic input at this point in time
		% 0-1 values at current time
		%
	    for i=1:sim.N_nn,
		if (t <= sim.net.delay_GABA(i)),
		    net_GABA(i)=0;
		else
                    s=sim.instrument.allvm(i_upd,i,t-sim.net.delay_GABA(i)) ...
			> sim.activity_thr;
		    net_GABA(i)=s*sim.net.strength_GABA(i);
			end;
		
		if (t <= sim.net.delay_AMPA(i)),
		    net_AMPA(i)=0;
		else
                    s=sim.instrument.allvm(i_upd,i,t-sim.net.delay_AMPA(i)) ...
			> sim.activity_thr;
		    net_AMPA(i)=s*sim.net.strength_AMPA(i);
			end;
		
		if (t <= sim.net.delay_NMDA(i)),
		    net_NMDA(i)=0;
		else
                    s=sim.instrument.allvm(i_upd,i,t-sim.net.delay_NMDA(i)) ...
			> sim.activity_thr;
		    net_NMDA(i)=s*sim.net.strength_NMDA(i);
			end;
		end;
	     
		%
		% add external input, if active
		% NOW: AMPA = NMDA;
		%
            if (find(sim.net.ext_input_intervals == t)),
                net_NMDA(sim.N_nn+1:end)  = all_nn_inputs(1,t);
                net_AMPA(sim.N_nn+1:end)  = all_nn_inputs(1,t);
                net_GABA(sim.N_nn+1:end)  = all_nn_inputs(2,t);
	    else
                net_NMDA(sim.N_nn+1:end)  = 0;
                net_AMPA(sim.N_nn+1:end)  = 0;
                net_GABA(sim.N_nn+1:end)  = 0;
                end;

		% get the stuff through the networks
		%
	    % I_presyn_AMPA = net_AMPA * sim.net.G_AMPA;
	    % I_presyn_GABA = net_GABA * sim.net.G_GABA;
	    % I_presyn_NMDA = net_NMDA * sim.net.G_NMDA;
	    I_Syn(1,:) = net_AMPA * sim.net.G_AMPA;
	    I_Syn(2,:) = net_GABA * sim.net.G_GABA;
	    I_Syn(3,:) = net_NMDA * sim.net.G_NMDA;
		
all_syn(t,:) = I_Syn(1,:);
all_net_AMPA(t,:) = net_AMPA;

		%
		% with all the pre-synaptic inputs, we can now
		% run the N_nn neurons
		% and record the result
		%

	     [nn_params] = run_neuron_vector(sim, I_Syn, nn_params);

		%
		% save the V0
		%
	     sim.instrument.allvm(i_upd,:,t) = nn_params(:,1);

		%
		% calculate recent activity
		%
	     cact = find(nn_params(:,1)> sim.activity_thr);
	     recent_act = recent_act + ...
		length(find(recent_act_cntr(cact) > sim.activity_win));
	     recent_act_cntr = recent_act_cntr + 1;
	     recent_act_cntr(cact) = 0;
%	     recent_act= recent_act + ...
%                    length(find(nn_params(:,1)> sim.activity_thr));
	     if (mod(t,100) == 1),
		 dt=toc;
	         fprintf('%.2d: t=%d |V_m|=%f |act|=%d T=%.2d[s]\n', ...
		    i_upd, t, mean(nn_params(:,1)),recent_act, dt);
        	 recent_act=0;
		 tic;
		end;

	    end;   % time loop

	end;       % i_update loop

	save(fn);

end;
