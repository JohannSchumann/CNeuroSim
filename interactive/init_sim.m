% 
%	set up the sim data structure with default values
%
% 	$Revision:$
%
%

if (exist('T_sim')),
	T_upd = T_sim;
else
	T_upd = 1000;
	T_sim = T_upd;
end;

if (~exist('N_nn')),
	N_nn = 1;
end;

if (~exist('FN')),
	FN='interactive';
end;

if (~exist('neuron_type')),
	neuron_type = 'neuron_nmda3';
end;


FN_INP='dummy';

sim.N_nn = N_nn;
sim.exp = 'EXPERIMENT';
sim.input_units = 'current    ';
sim.activity_thr =-0;
%sim.activity_win = 7;
	% this enables to recognize freq > 100Hz, but might yield problems
	% with low firing rates
sim.activity_win = 2;
sim.neuron = neuron_type;
sim.offset = 1;
sim.get_channels = 1;
sim.description = 'interactive experiment';
sim.T_upd = T_upd;
sim.ts = 1; % basic time unit = ms
sim.nA = 1/2.3;
sim.nA_units       = 1;

sim.date=now;
sim.script='interactive.m';
sim.FN = FN;
sim.FN_INP = FN_INP;

	%
	% some control variables (most of them not used frequently)
	% need to be in sim
	%
sim.do_sim         = 1;
sim.do_gen_inputs  = 1;
sim.do_analyze_inp = 0;
sim.do_save_inputs = 0;
sim.do_table       = 0;
sim.do_hold        = 0;
sim.N_upd          = 1;	% number of update cycles


%-----------------------------------------------
path(path,'../neuron');
path(path,'../analysis');
path(path,'../input');
path(path,'../syn_response');
path(path,'../gain_filter');
path(path,'../interactive');
path(path,'../netsim');

[sim,dummy1, dummy, nn_mu_params] = eval(sprintf('init_%s(sim)',sim.neuron));
        % definition of neuron mu parameters

%-----------------------------------------------
        %
        % individual parameters
        %
        % 1 K
        % 2 CaL
        % 3 KAs
        % 4 Na
        % 5 NaS
        % 6 Kaf
        % 7 Kir
        % 8 AHP
        % 9 M
        % 10 mu_NMDA (for Cai)
        % 11 mu_EBIO  (Cai <-> SK)
        % 12 NMDA strength (par(12)*I_nmda)
        % 13 H
	% 14 mu_AMPA (default = 1) injected into AMPA (=soma) = mu(14)*I_S(1,:)
	% 15 mu_NMDA   injected into NMDA = mu(15)*I_S(1,:)
        %


offset = 100;   % for plots

rand('seed',99);
randn('seed',1387);

init_input;

	% defaults for run_sim_gain

exc_Mp  = [500, 1000, 2000, 3000];
inh_Mn  = [50, 100, 200, 300];

	%
	% display I_S_inj instead of I_S
	%
sim_gain.disp_inp_inj = 1;
