%
%	calculate inter-spike intervals
%
%	$Revision:$
%
function [m_isi, s_isi] = calc_isi(sim)

for i=1:sim.N_nn,
%	is=reshape(sim.instrument.spiketrain(1,i,:),sim.T_upd,1);
	is=find(sim.instrument.spiketrain(1,i,:)>0);
	iisi = [is;sim.T_upd] - [0;is];
iisi
	m_isi(i) = mean(iisi(2:end-1));
	s_isi(i) = std(iisi(2:end-1));
	end;
