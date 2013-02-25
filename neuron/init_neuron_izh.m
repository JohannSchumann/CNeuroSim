% init_neuron_izh
%
% initialize neuron state vector
%
%
%	$Revision:$
%
function [sim, nn_params, l_param, nn_mu_params] = init_neuron_izh(sim, varargin)

N_states = 2;
%	V		1
%	U

N_params = 6;
 	% 1 a
        % 2 b
        % 3 c
        % 4 d
	% 5 mu-excit
	% 5 mu-inh

sim.nn_parnames = [ ...
{'a'}, ...
{'b'}, ...
{'c'}, ...
{'d'}, ...
{'mu-excit'}, ...
{'mu-inh'} ...
];

l_param = 20 + N_params;

nn_params = zeros(1,l_param);

if (nargin > 1),
	nn_mu_params_in = varargin{:};
else
	nn_mu_params_in = zeros(N_params);
end;


%
% start values
%
V_0  = (1/0.08)*(-(5-nn_mu_params_in(1,2).^2) - ...
	    sqrt(abs((5-nn_mu_params_in(1,2)).^2 - 4*0.04*140)));
U  = nn_mu_params_in(1,2)*V_0;


nn_params(1:N_states)=[V_0,U];

	%
	% standard neuron has mu's of 1.0
	%
nn_params(21:20+N_params) = 1.0;

sim.N_states = N_states;
sim.N_params = N_params;

sim.integration = 'euler';

%----------------------------------------------------
nn_mu_params=zeros(sim.N_nn,sim.N_params)+1;

nn_mu_params(:,1) = 0.02;
nn_mu_params(:,2) = 0.2;
nn_mu_params(:,3) = -65;
nn_mu_params(:,4) = 8;
nn_mu_params(:,5) = 5;
nn_mu_params(:,6) = 5;

	%
	% some global settings
	%
sim.display.channels.Cai=0;
sim.display.channels.NMDA=0;
sim.get_channels = 0;

	%
	% avoid multiple counting of "longer" peaks
	%
sim.activity_win = 7;

