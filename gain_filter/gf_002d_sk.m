% 	gf_002d_sk.m
%	script to set up simulation and generate a gain-plot
%	(firing rate over input) for various parameters
%	
%	$Revision:$
%
%
%
%
clear
clear all
clear functions

do_sim         = 1;
do_gen_inputs  = 1;
do_analyze_inp = 0;
do_save_inputs = 0;
do_table       = 0;
nA_units       = 0;

N_upd	= 1;	% number of update cycles
N_nn	= 1;	% number of neurons
T_upd   = 2000;  % length of each update cycle [ms]

FN='gf_002d_sk';
FN_INP='dummy';

sim.exp = 'EXPERIMENT';
sim.input_units = 'current    ';
sim.activity_thr =-0;
sim.activity_win = 7;
sim.neuron = 'neuron_nmda3';
sim.offset = 1;
sim.get_channels = 1;
sim.description = 'gain experiment 001';
sim.T_upd = T_upd;
sim.N_nn = N_nn;
sim.N_upd = N_upd;
sim.do_sim=do_sim;
sim.do_gen_inputs  = do_gen_inputs;
sim.do_analyze_inp = do_analyze_inp;
sim.do_save_inputs = do_save_inputs;
sim.do_table       = do_table;
sim.ts = 1;
sim.nA_units=nA_units;
sim.nA=1/2.3;

sim.date=now;
sim.script='gf_001.m';
sim.FN = FN;
sim.FN_INP = FN_INP;

%-----------------------------------------------
path(path,'../neuron');
path(path,'../analysis');
path(path,'../input');
path(path,'../syn_response');

[sim] = eval(sprintf('init_%s(sim)',sim.neuron));
        % definition of neuron mu parameters

nn_mu_params=zeros(N_nn,sim.N_params)+1;
%-----------------------------------------------
        %
        % set individual parameters
        %
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
	% 14 mu_AMPA (default = 1) injected into AMPA (=soma) = mu(14)*I_S(1,:)
	% 15 mu_NMDA   injected into NMDA = mu(15)*I_S(1,:)
        %

        % no KAs
nn_mu_params(:,3) = 0;
        % CaL
nn_mu_params(1:10,2) = 1;
        % WITH H channel
nn_mu_params(:,13) = 0.5;

        %
nn_mu_params(:,12) = 1;

        %
        % Kir
        %
nn_mu_params(:,7) = 1;

        %
        % NaS and Kaf
        %
nn_mu_params(:,5) = 1;
nn_mu_params(:,6) = 1;

        %
        % pre-start values for Cai
        %
sim.nn_start_val(1:N_nn,14)=0;



        %
        % definition of input parameters
        %

do_hold = 0;

input_params.description='dc';
input_params.type = 12345;
input_params.Mn = 0;  	% Mn
input_params.Mp = 100;  	% Mp
input_params.lambdan = 9999;  	% lambda_n
input_params.lambdap = 100;  	% lambda_p
input_params.corrp = 0.0;	% rel. correlation for Mp
input_params.corrn = 0.0;	% rel. correlation for Mn
input_params.g0 = -10;	% g_0

input_params.sin_ampl = 0;
input_params.ss_ampl = 0;
input_params.markov_ampl = 0;
%
%
% short pulse
%
input_params.dc_start = 1;
input_params.dc_stop = sim.T_upd;
	% dc set in the loop
input_params.dc         = 0;


input_params.eta        = 0;            % sigma^2 of randn noise


input_params.start      = 1;    % start offset

input_params_inh.description='dc';
input_params_inh.type = 12345;

input_params_inh.Mn = 20;  	% Mn
input_params_inh.Mp = 0;  	% Mp
input_params_inh.lambdan = 40;  	% lambda_n
input_params_inh.lambdap = 9999;  	% lambda_p
input_params_inh.corrp = 0.0;	% rel. correlation for Mp
input_params_inh.corrn = 0.0;	% rel. correlation for Mn
input_params_inh.g0 = 10;	% g_0

input_params_inh.sin_ampl = 0;
input_params_inh.ss_ampl = 0;
input_params_inh.markov_ampl = 0;
%
input_params_inh.dc_start = 1;
input_params_inh.dc_stop = sim.T_upd;
	% dc set in the loop
input_params_inh.dc         = 0;


input_params_inh.eta        = 0;            % sigma^2 of randn noise


input_params_inh.start      = 1;    % start offset


rand('seed',99);
randn('seed',1387);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (do_sim == 1),

  % mp=[100,200,300,400,500];
  % mn=[20,40,60,80,100];
  mp=50:50:400;
  mn=10:10:80;
  mp=50:500:2050;
  mn=10:100:410;
  len=length(mp);
idx0 = 1;
%for nn_id = 0:2.5:10,
for nn_id = 0:3:10,
idx=1;
for dc_i = 1:len,
  dc=mp(dc_i);
  idxx=1;
  for mu2=0,

	input_params.g0 = -2;
	input_params_inh.g0 = 2;
	input_params.Mp = mp(dc_i);
	input_params_inh.Mn = mn(dc_i);
%	all_dc = input_params.g0 + input_params_inh.g0;
%	inp_dc(idx0,idx,idxx) = input_params.g0 + input_params_inh.g0;
	all_dc = 99;
	inp_dc(idx0,idx,idxx) = 99;

		% input-AMPA
%	nn_mu_params(1,14) = 0.9;
		% input-NMDA
%	nn_mu_params(1,15) = 0.1;

		% CaL
%	nn_mu_params(1,2) = 0.6 + 0.04*(nn_id);
	nn_mu_params(1,2) = 1.0;

		% AHP - SK
	nn_mu_params(1,8) = 0.0 + 0.125*(nn_id);

	thispar(idx0) = nn_mu_params(1,8);

%		% EBIO
%	nn_mu_params(1,8) = 1.0 + 1*(nn_id);
%
		% NMDA  contribution to Cai
	nn_mu_params(1,10) = 1;

	if (do_table == 1),
            fprintf('Neuron %d( ) %f %f %f %f\n', nn_id, ...
                nn_mu_params(1,10),...
                nn_mu_params(1,8),...
                nn_mu_params(1,2),...
                nn_mu_params(1,11));
	else

	    fprintf('running with dc=%f nnid=%d\n', all_dc, nn_id);
	end;

	run_sr4;

 	m_Cai = mean(sim.instrument.I_Channels(1).Cai(max(1,end-100):end));

        m_inp = mean(nn_inputs(1,:)+nn_inputs(2,:),2);

        inp_dc(idx0,idx,idxx) = m_inp;
        inp_exc(idx0,idx,idxx) = mean(nn_inputs(1,:));
        inp_inh(idx0,idx,idxx) = mean(nn_inputs(1,:));

	fprintf('dc=%f |I_s|=%f |Cai|=%f\n', dc,m_inp, m_Cai);

	[spi, spt, act] = calc_spiketrain(vm, sim);
%	out_freq(idx0,idx,idxx) = act;
	out_act(idx0,idx,idxx) = act;
        m_isi=sim.instrument.m_isi;
        if (m_isi ~= -99),
                out_freq(idx0,idx,idxx) = 1000/m_isi;
        else
                out_freq(idx0,idx,idxx) = 0;
        end;

	
	out_early(idx0,idx,idxx) = 0;
        if (~isempty(spi)),
          if (spi(end) < 0.8*T_upd),
		out_early(idx0,idx,idxx) = 1;
                fprintf('stopped too early\n\n');
                end;
        end;

        iisi = [spi sim.T_upd] - [0 spi];

	%out_freq_ss(idx0,idx,idxx) = mean(iisi(max(1,length(iisi)-5):end));
        mm = mean(iisi(max(1,length(iisi)-10):end));
        if (mm==0),
                out_freq_ss(idx0,idx,idxx) = 0;
        else
                out_freq_ss(idx0,idx,idxx) = 1000/mm;
        end;

	out_Cai(idx0,idx,idxx) = m_Cai;
	inp_vm(idx0,idx,idxx) = ...
          mean(reshape(sim.instrument.allvm(1,1,1:sim.T_upd),1,sim.T_upd));
	inp_mean(idx0,idx,idxx) = m_inp;

	idxx=idxx+1;

        end;
      idx = idx+1;

    end;
idx0 = idx0 + 1;
  end;
	
if (do_table == 0),
	save(sprintf('%s.dat',FN));
	end;
else
	load(sprintf('%s.dat',FN), '-mat');

end;

if (do_table == 0),

	inp_dc = [zeros(size(inp_dc,1)) inp_dc];
	out_freq= [ zeros(size(inp_dc,1)) out_freq];
	out_freq_ss= [ zeros(size(inp_dc,1)) out_freq_ss];
	theinput = [zeros(size(inp_mean,1)) inp_mean];

if (nA_units),
	theinput = theinput / 2.3;
	end;

if (1 == 1),
N_nns = idx0-1;
figure
col=get(gca,'ColorOrder');
for i=1:N_nns,
        [a,b]=sort(theinput(i,:));
        plot(-theinput(i,b),out_freq(i,b)', 'Color', col(i,:));
        hold on;
        end;
if (nA_units),
	xlabel('Input magnitude [nA]', 'FontSize', [16]);
else
	xlabel('Input magnitude [\muAscm^{-2}]', 'FontSize', [16]);
end;
ylabel('Firing rate [Hz]', 'FontSize', [16]);
axis([0,3,0,50]);
legend({ sprintf('%.1f',thispar(1)), 
         sprintf('%.1f',thispar(2)), 
	 sprintf('%.1f',thispar(3)), 
         sprintf('%.1f',thispar(4)), 
         sprintf('%.1f',thispar(5))} ...
 , 'Location','SouthEast');
%legend({ 'N1', 'N2', 'N3', 'N4', 'N5'} ...
% , 'Location','NorthWest');

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


end;





if (1==0),

	figure
	plot(-inp_dc(1,:),out_freq'./T_upd*1000);
	xlabel('Input magnitude [\muAscm^{-2}]', 'FontSize', [16]);
	ylabel('Firing rate [Hz]', 'FontSize', [16]);
	%axis([0.8,1.2,0,20]);
	axis([0,7,0,80]);
	%legend({ 'N1', 'N2', 'N3', 'N4', 'N5', 'N6', 'N7', 'N8', 'N9', 'N10'} ...
	legend({ 'N1', 'N2', 'N3', 'N4'} ...
 	, 'Location','SouthEast');


	print('-depsc', sprintf('%s.eps',FN));

	end;

print_res(FN, sim, input_params, nn_mu_params, all_nn_inputs);

%contour(-inp_dc(:,1),[1:0.1:1.5],out_freq')


end;
