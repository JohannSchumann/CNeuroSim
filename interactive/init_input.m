%
% 	definition of input parameters
%
%	$Revision:$


input_params.description='dc';
input_params.type = 12345;
input_params.Mn = 0;  	% Mn
input_params.Mp = 300;  	% Mp
input_params.lambdan = 9999;  	% lambda_n
input_params.lambdap = 100;  	% lambda_p
input_params.corrp = 0.0;	% rel. correlation for Mp
input_params.corrn = 0.0;	% rel. correlation for Mn
input_params.g0 = -2;	% g_0

input_params.sin_ampl = 0;
input_params.ss_ampl = 0;
input_params.markov_ampl = 0;
%
%
% short pulse
%
input_params.dc_start = 1;
input_params.dc_stop = sim.T_upd;
	% dc set in the loop
input_params.dc         = 0;


input_params.eta        = 0;            % sigma^2 of randn noise


input_params.start      = 1;    % start offset

input_params.I0_p = 0.1;  	%nA
input_params.tau_p = 2.5;	% ms;
input_params.I0_n = -0.033;  	%nA
input_params.tau_n = 3;		% ms;

input_params.corr_factor = 0;
input_params.W_size = 8;


input_params_inh.description='dc';
input_params_inh.type = 12345;

input_params_inh.Mn = 20;  	% Mn
input_params_inh.Mp = 0;  	% Mp
input_params_inh.lambdan = 40;  	% lambda_n
input_params_inh.lambdap = 9999;  	% lambda_p
input_params_inh.corrp = 0.0;	% rel. correlation for Mp
input_params_inh.corrn = 0.0;	% rel. correlation for Mn
input_params_inh.g0 = -2;	% g_0  !! same sign as input_params.g0 !!

input_params_inh.sin_ampl = 0;
input_params_inh.ss_ampl = 0;
input_params_inh.markov_ampl = 0;
%
input_params_inh.dc_start = 1;
input_params_inh.dc_stop = sim.T_upd;
	% dc set in the loop
input_params_inh.dc         = 0;


input_params_inh.eta        = 0;            % sigma^2 of randn noise


input_params_inh.start      = 1;    % start offset

input_params_inh.I0_p = 0.1;  	%nA
input_params_inh.tau_p = 2.5;	% ms;
input_params_inh.I0_n = -0.033;  	%nA
input_params_inh.tau_n = 3;		% ms;

input_params.corr_factor = 0;
input_params.W_size = 8;

rand('seed',99);
randn('seed',1387);

