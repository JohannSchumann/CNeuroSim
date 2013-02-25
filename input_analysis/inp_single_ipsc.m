% 	demonstrate the various types of inputs
%	default: single IPSP pulse
%
%	$Revision:$
%
%
%
%
clear
clear all
clear functions


N_upd	= 1;	% number of update cycles
N_nn	= 5;	% number of neurons
ts      = 1;
T_upd   = 1000;  % length of each update cycle [ms]

FN='inp_single_ipsc';


sim.FN = FN;

%-----------------------------------------------
path(path,'../neuron');
path(path,'../analysis');
path(path,'../input');

%-----------------------------------------------
	%
	% definition of input parameters
	%

	%
	% Poisson-distributed spike trains
	%
input_params.description='uncorr-irreg+sin';
input_params.type = 12345;
input_params.Mn = 1;  	% Mn
input_params.Mp = 0;  	% Mp
input_params.lambdan = 500;  	% lambda_n
input_params.lambdap = 5000000;  	% lambda_p
input_params.corrp = 0.0;	% rel. correlation for Mp
input_params.corrn = 0.0;	% rel. correlation for Mn
input_params.g0 = -1;	% g_0


input_params.sin_width=99;  %ms
input_params.sin_ampl = 0;	
input_params.sin_freq =  99; % 
input_params.sin_dfreq = 99; % 

input_params.ss_ampl = 0;

input_params.ss_train = [ ];
input_params.ss_width = 5;
input_params.ss = [];

input_params.markov_ampl = 0;
input_params.markov_sigma = 0.2;
input_params.markov_tau = 1/20;

	%
	% biased Gaussian noise
	%
input_params.dc_start = 1;
input_params.dc_stop = T_upd;

input_params.dc 	= 0;
input_params.eta	= 0;		% sigma^2 of randn noise

input_params.start	= 1;	% start offset

%-------------------------------------------------------------

rand('seed',99);
randn('seed',1387);

%-------------------------------------------------------------

sim.N_upd = N_upd;
sim.N_nn = N_nn;
sim.T_upd = T_upd;
sim.ts = ts;

all_nn_inputs = gen_nn_inputs(sim, input_params);

if (1==0),
	inp_analysis(-all_nn_inputs, input_params, sim);
end;


figure
st=min(find(all_nn_inputs));

plot(1:20,-all_nn_inputs(st-3:st+16),'k','Linewidth',1.5);
ylabel('IPSC [muA/cm^2]','Fontsize',[16]);
xlabel('time [ms]','Fontsize',[16]);

%------------------------------------------------------------------
% print the stuff to file
%------------------------------------------------------------------
fn_eps =sprintf('%s.eps', FN);
print('-depsc', fn_eps);
fn_jpg =sprintf('%s.jpg', FN);
print('-djpeg', fn_jpg);
fn_tiff =sprintf('%s.tiff', FN);
print('-dtiff', fn_tiff);
fn_png =sprintf('%s.png', FN);
print('-dpng','-r72', fn_png);
