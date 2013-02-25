% 	init_neuron_nmda4.m
%
% initialize neuron state vector
%
%  with EBIO parameter
%
%	$Revision:$
%
function [sim, nn_params, l_param, nn_mu_params] = init_neuron_nmda4(sim)

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
% 	m0_m		14
% 	Cai_0		15
% 	s1_nmda		16
% 	s2_nmda		17
% 	m0_h		18

N_params = 13;
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
	m0_kas, h0_kas, m0_nas,m0_kir, m0_kaf, h0_kaf, m0_AHP, m0_m, Cai_0, nmda_0, nmda_0, m0_h]';

	%
	% standard neuron has mu's of 1.0
	%
nn_params(21:20+N_params) = 1.0;

sim.N_states = N_states;
sim.N_params = N_params;

sim.integration = 'ode';

fprintf('setting mu parameters =1.0...\n');
nn_mu_params=zeros(sim.N_nn,sim.N_params)+1;
