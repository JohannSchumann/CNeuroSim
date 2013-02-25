%
% generate_inputs_corr
%
% generate correlated input using a moving window technique
%
% or a simple %-technique  (input_params.corr_mode=1)
% 
% N = sim.T_upd+input_params.start: length of sequence
% 
%
function inp = generate_inputs_corr(N, sim, input_params)

inp = zeros(sim.T_upd+input_params.start,1);

W_size = input_params.W_size;
	%
	% generate "pool" of uncorrelated poisson sequences
	%
I_p = zeros(N, input_params.Mp);
for i=1:input_params.Mp,
	I_p(:,i) = inp_poisson(input_params, ...
			N, 1, 0, input_params.lambdap,0,sim.ts);
	end;

if (isfield(input_params,'corr_mode') && input_params.corr_mode==1),

	fprintf('Generating correlated input summing\n');

	I_s = zeros(sim.T_upd+input_params.start,1);
		% these are the "synchronized" inputs
	I_s = I_s + ...
		input_params.corr_factor*input_params.M_p*I_p(:,1);
	N=floor(input_params.corr_factor*input_params.M_p);
	for i=2:N+1,
		I_s = I_s + I_p(:,i);
	end;

	inp = I_s;

%---------------------------------------------------------
else
%---------------------------------------------------------

cf = floor(W_size *(1-input_params.corr_factor))+1;
N_in = floor(input_params.Mp/W_size);

fprintf('Generating correlated input (Windows) with W_size=%d N_in=%d cf=%d\n',...
	W_size, N_in,cf);

if (cf <=0 | cf > W_size + 1),
	fprintf('correlation factor must be in 0..1\n');
	return;
	end;

j = cf;
W = j-1;
w_start=1;
for i=1:N_in,
	I_s = zeros(sim.T_upd+input_params.start,1);
	for w=0:W_size-1,
		I_s = I_s + I_p(:,w_start+w);
		end;
	w_start=w_start+W;
	inp= inp + I_s;
	end;

end;

