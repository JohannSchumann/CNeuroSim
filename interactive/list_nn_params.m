%
% script to list current nn_params
%
%	$Revision:$
%

fprintf('\nCurrent values of settable mu parameters\n');
for i=1:sim.N_params,
	fprintf('%2.2d %10.10s: ', i, cell2mat(sim.nn_parnames(i)));
	for n = 1:sim.N_nn,
		fprintf('%.2f    ', nn_mu_params(n,i));
		end;
	fprintf('\n');
	end;

fprintf('\nto set:   nn_mu_params(neuron#, par#) = value\n');
fprintf('or        nn_mu_params(:, par#) = [v1, v2,...]''\n');
fprintf('          NOTE: TRANSPOSE required here       ^\n');
