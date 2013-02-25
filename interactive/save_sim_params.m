%
% script for saving the sim parameters
%
%	$Revision:$

fprintf('Saving selected sim parameters:\n');
fprintf('  input_params\n');
fprintf('  input_params_inh\n');
fprintf('  nn_mu_params\n');
fprintf('\n');

save(sprintf('%s_sim_params.mat',FN), ...
	'input_params', 'input_params_inh', 'nn_mu_params');

fprintf('Selected simulation parameters saved.\n');

