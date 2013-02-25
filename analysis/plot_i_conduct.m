% 	script: plot synaptic input (current) vs. synaptic input (conductance)
%
% 	based upon data from sr_kas.* input and simulation data
%
%	$Revision:$
%

FN='sr_kas_conduct_corrW_001_02';
FN_plot='i_g_corr.eps';
offset = 1;
ax_lim = [0,500,-0.2,0.1];

%FN='sr_kas_conduct_uncorrW_001_06';
%FN_plot='i_g_uncorr.eps';
%offset=1500;
%ax_lim = [0,500,-0.05,0.02];

%----------------------------------
fn=sprintf('%s.dat', FN);
load(fn, '-mat');

selected_neuron = 1;
nn=selected_neuron;
LW=2;

figure;


vm=reshape(sim.instrument.allvm(1,nn,offset:sim.T_upd),1, sim.T_upd-offset+1);
vm(find(vm==0)) = 1e-6;

% V = I * R = I /G
% G = I / V
%
nn_input_conduct = -nn_inputs(nn,offset:end) ./ vm;

subplot(2,1,1);
plot(nn_input_conduct(1:end-1), 'k-', 'Linewidth',LW);
%set(gca,'Visible','off');
axis(ax_lim);
ylabel('mS/cm^2');

subplot(2,1,2);
plot(-nn_inputs(nn,offset:end), 'Linewidth',LW);
%set(gca,'Visible','off');
ylabel('\muA/cm^2');
ax=axis;
ax(2)=500;
axis(ax);

print('-deps', FN_plot);
