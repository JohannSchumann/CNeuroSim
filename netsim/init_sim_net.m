
%
% initialize for network
% currently: IZH only

N_nn = 100;

neuron_type='neuron_izh';

%-----------------------------------------------
path(path,'../neuron');
path(path,'../analysis');
path(path,'../input');
path(path,'../syn_response');
path(path,'../gain_filter');
path(path,'../interactive');
path(path,'../netsim');
path(path,'../graphs');


init_sim;
init_net;

%---------------------
% just one example
%
sim.net.G_AMPA(1:N_nn, 1:N_nn) =gen_rand(N_nn, 0.03*(N_nn*N_nn));
sim.net.delay_AMPA(:) =7;
sim.net.ext_input_intervals=1:600;
