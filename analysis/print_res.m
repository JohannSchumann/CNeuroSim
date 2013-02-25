%	print_res
%	print information about the experiment as table into file
%
%	FN:	name of output file
%	sim	simulation structure
%	input_params
%	nn_mu_params
%	all_nn_inputs
%
%	$Revision:$

function print_res(FN, sim, input_params, nn_mu_params, all_nn_inputs)

ch_id = [ {'K'}, {'CaL'}, {'KAs'}, {'Na'}, {'NaS'},{'Kaf'},{'Kir'},{'AHP'},{'M'},{'NMDA(*)'}];

	% 1 K
	% 2 CaL
	% 3 KAs
	% 4 Na
	% 5 NaS
	% 6 Kaf
	% 7 Kir
	% 8 AHP
	% 9 M
	% 10 NMDA

f = fopen(sprintf('%s.res',FN), 'w');

fprintf(f, '%%-------------- Experiment Parameters --------------\n');
fprintf(f, '%%  Filename: 		%s\n', sim.FN);
fprintf(f, '%%  Input Filename:		%s\n', sim.FN_INP);
fprintf(f, '%%  descr. generated:	%s\n', datestr(now));
fprintf(f, '%%  Script Filename:	%s\n', sim.script);
	[a,pwd] = system('pwd');
fprintf(f, '%%  Directory:		%s\n', pwd);

fprintf(f, '%%----Simulation run\n');
fprintf(f, '%%  T_upd		%d ms\n',sim.T_upd);
fprintf(f, '%%  Number neurons	%d\n',sim.N_nn);
fprintf(f, '%%  offset 		%d ms\n',sim.offset);
fprintf(f, '%%  Date 		%s \n',datestr(sim.date));

fprintf(f, '%%----Channels and parameters\n');
fprintf(f, '%%  Neuron type: 		%s\n', sim.neuron);
for nn=1:sim.N_nn,
    for i=1:10,
	if (nn_mu_params(1,i) ~=0),
	   fprintf(f, '%%    Neuron %d: %s	mu= %.2f\n', nn, cell2mat(ch_id(i)),...
		nn_mu_params(nn,i));
	   end;
        end;
    end;
fprintf(f, '%%----Inputs\n');
fprintf(f, '%%  Description:	%s\n',input_params.description);
fprintf(f, '%%  |I_S|		%f\n', -mean(all_nn_inputs(1,sim.offset:end)));
fprintf(f, '%%  input_params parameters\n');
fprintf(f, '%%  .start		%d\n', input_params.dc_start);
fprintf(f, '%%  .dc			%f\n', input_params.dc);
fprintf(f, '%%  .eta (noise)		%f\n', input_params.start);
fprintf(f, '%%  .dc_start	%d\n', input_params.dc_start);
fprintf(f, '%%  .dc_stop	%d\n', input_params.dc_stop);
if (input_params.sin_ampl > 0),
  fprintf(f, '%%  distorted sinuisoidal (highy correlated)\n');
  fprintf(f, '%%  .sin_width	%f\n', input_params.sin_width);
  fprintf(f, '%%  .sin_freq	%f\n', input_params.sin_freq);
  fprintf(f, '%%  .sin_ampl	%f\n', input_params.sin_ampl);
  end;
if (input_params.g0 ~= 0),
  fprintf(f, '%%  sum of Poisson-distributed EPSPs and IPSPs\n');
  fprintf(f, '%%  .g0 (strength)	%f\n', input_params.g0);
  fprintf(f, '%%  .Mp		%f\n', input_params.Mp);
  fprintf(f, '%%  .lambdap	%f [ms]\n', input_params.lambdap);
  fprintf(f, '%%  .Mn		%f\n', input_params.Mn);
  fprintf(f, '%%  .lambdan	%f [ms]\n', input_params.lambdan);
  end;
if (input_params.type == 6),
  fprintf(f, '%% special input type 6\n');
  end;


fprintf(f, '%%-------------- Experiment Parameters --------------\n');
fclose(f);
