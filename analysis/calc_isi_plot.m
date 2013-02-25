function [m_isi, s_isi] = calc_isi_off(sim,off,do_plot)

for i=1:sim.N_nn,
	is=find(sim.instrument.spiketrain(1,i,off:end)>0);
	iisi = [is;sim.T_upd] - [0;is];
	if (do_plot),
		figure;
		hist(iisi,10:10:60);
		end;
%	xx = find(iisi < 65 & iisi >10);
%	m_isi(i) = mean(iisi(xx));
%	s_isi(i) = std(iisi(xx));
	m_isi(i) = mean(iisi(2:end));
	s_isi(i) = std(iisi(2:end));
	end;
