%
%
%       ex_001:
%       top level script to run 4 different IZH neurons
%       on generated input with different mu parameters
%       and produce figure with input, raster plot and spike
%       diagram
%	figure and data saved in FN
%
%       $Revision:$
%

clear
N_nn=4;
FN='Nex_izh_001';
neuron_type = 'neuron_izh';

init_sim

nn_mu_params(:, 2) = [ 0.05, 0.1, 0.2, 0.3]';

list_nn_params

exc_Mp  = 200:250:3000;
inh_Mn  = 20:25:300;
run_sim;

plot_iv;
%print_fig;
%save_sim;

