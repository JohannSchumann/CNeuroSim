% init_neuron_nmda3
% initialize neuron state vector
%
%  with EBIO parameter
%
%	$Revision:$
%
function [sim, nn_params, l_param, nn_mu_params] = init_neuron_nmda3(sim, varargin)

N_states = 18;
%	V_0		1
%	m0_na		2
%	h0_na		3
%	n0_k		4
%	m0_CaL		5
%	h0_CaL		6
%	m0_kas		7
% 	h0_kas		8
% 	m0_nas		9
%	m0_kir		10
% 	m0_kaf		11
% 	h0_kaf		12
% 	m0_AHP		13
% 	Cai_0		14
% 	m0_m		15
% 	s1_nmda		16
% 	s2_nmda		17
% 	m0_h		18

N_params = 17;
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
	% 12 NMDA strength (I_NMDA = par(12)*nmda_in)
	% 13 H
	% 14 mu_AMPA (default = 1) injected into AMPA (=soma) = mu(14)*I_S(1,:)
	% 15 mu_NMDA   injected into NMDA = mu(15)*I_S(1,:)
	% 16 mu_GABA   mu(16)*I_S(2,:)
	% 17 mu_CaL_Cai:   CaL --> Cai

sim.nn_parnames = [ ...
{'mu_K'}, ...
{'mu_CaL'}, ...
{'mu_KAs'}, ...
{'mu_Na'}, ...
{'mu_NaS'}, ...
{'mu_Kaf'}, ...
{'mu_Kir'}, ...
{'mu_SK'}, ...
{'mu_M'}, ...
{'mu_Cai_NMDA'}, ...
{'mu_EBIO'}, ...
{'mu_I_NMDA'}, ...
{'mu_H'}, ...
{'mu_AMPA'}, ...
{'mu_NMDA'}, ...
{'mu_GABA'}, ...
{'mu_CaL_Cai'} ...
];



l_param = 20 + N_params;

nn_params = zeros(1,l_param);

%
% start values
%
V_0  = -74.6;	% mV
Cai_0 = 0;

[a,b,c,m0_na, h0_na ] = ina(V_0,0,0);
[a,b,n0_k ] = ik(V_0,0);
%% [a,b,c,m0_CaL, h0_CaL ] = ical(V_0,0,0);
[a,b,c,m0_CaL, h0_CaL ] = ica_traub(V_0,0,0);

[a,b,c,m0_kas, h0_kas ] = ikas(V_0,0,0);

[a,b,m0_nas ] = inap(V_0,0);
[a,b,m0_kir ] = ikir(V_0,0);
[a,b,c,m0_kaf, h0_kaf ] = ikaf(V_0,0,0);


[a,b,m0_AHP] = iAHP(V_0, 0, Cai_0);

[a, b, m0_m ] = im(V_0,0);

[a, b, m0_h ] = ih(V_0,0);

nmda_0 = 0;

	%
	% set the channel states
	%

nn_params(1:N_states)=[V_0, m0_na, h0_na, n0_k, m0_CaL, h0_CaL, ...
	m0_kas, h0_kas, m0_nas,m0_kir, m0_kaf, h0_kaf, m0_AHP, Cai_0, m0_m, nmda_0, nmda_0, m0_h]';

	%
	% standard neuron has mu's of 1.0
	%
nn_params(21:20+N_params) = 1.0;

sim.N_states = N_states;
sim.N_params = N_params;

sim.integration = 'ode';

%----------------------------------------------------
	%
	% set default AHP-neuron mu parameters
	%
nn_mu_params=zeros(sim.N_nn,sim.N_params)+1;

        % no KAs
nn_mu_params(:,3) = 0;
        % CaL
nn_mu_params(:,2) = 0;
        % WITH H channel
nn_mu_params(:,13) = 0.5;

        %
nn_mu_params(:,12) = 1;

        %
        % Kir
        %
nn_mu_params(:,7) = 1;

        %
        % NaS and Kaf
        %
nn_mu_params(:,5) = 1;
nn_mu_params(:,6) = 1;

        %
        % pre-start values for Cai
        %
sim.nn_start_val(1:sim.N_nn,14)=0;
sim.display.channels.Cai=1;
sim.display.channels.NMDA=1;

