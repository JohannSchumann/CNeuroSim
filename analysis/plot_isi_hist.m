%	plot a histogram of ISIs
%
%
%	$Revision:$

function plot_isi_hist(FN, sim, offset)

fprintf('plot_isi_hist: ignoring offset\n');

N_nn = sim.N_nn;

pc = max(floor(N_nn/3),1) + 1;

figure;

for i=1:N_nn,
	subplot(pc,3,i);
        [spi, spt, act] = calc_spiketrain(sim.instrument.allvm(1,i,:), sim);
        iisi = [spi sim.T_upd] - [0 spi];
	hist(iisi(2:end-1));
	axis([0,100,0,10]);
	buf=sprintf('m/s/fc=%2.2f/%2.2f/%2.2f', ...
		sim.instrument.m_isi(1,i), sim.instrument.s_isi(1,i),...
		sim.instrument.s_isi(1,i)/sim.instrument.m_isi(1,i));
	title(buf);
end;

%------------------------------------------------------------------
% print the stuff to file
%------------------------------------------------------------------
fn_eps =sprintf('%s_hist.eps', FN);
print('-depsc', fn_eps);
fn_jpg =sprintf('%s_hist.jpg', FN);
print('-djpeg', fn_jpg);
