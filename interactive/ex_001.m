%
%	ex_001:
%	top level script to run 5 different neurons
%	on generated input with different mu parameters
%	and produce figure with input, raster plot and spike
%	diagram
%       figure and data saved in FN
%
%	$Revision:$
%

clear
N_nn=5;
FN='ex_001';
FN='Nex_001';
init_sim
list_nn_params
nn_mu_params(:,2)=1;
nn_mu_params(:,8)=[0,0.75,1.5,2.25,3];
exc_Mp  = 200:250:3000;
inh_Mn  = 20:25:300;
run_sim;

plot_iv;
%print_fig;
%save_sim;

