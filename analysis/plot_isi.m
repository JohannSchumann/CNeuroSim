%	calculate mean and std of inter-spike intervals
%	does not plot anything
%
%	$Revision:$
function [m_isi, s_isi] = plot_isi(sim)

for i=1:sim.N_nn,
	is=find(sim.instrument.spiketrain(1,i,:)>0);
	iisi = [is;sim.T_upd] - [0;is];
	m_isi(i) = mean(iisi(2:end-1));
	s_isi(i) = std(iisi(2:end-1));
	end;
