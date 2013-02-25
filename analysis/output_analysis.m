%
%	output analysis
%
%	$Revision:$
%
function output_analysis(sim)

filterlength = floor(sim.T_upd/10);


	%
	% means and overall variance
	%

mm = mean(reshape(sim.instrument.allvm(1,:,:),sim.N_nn,sim.T_upd));
vr = var(reshape(sim.instrument.allvm(1,:,:),1,sim.N_nn*sim.T_upd));

fprintf('Mean=%f Variance = %f\n', -mean(mm),sqrt(vr));

figure;

for i=1:sim.N_nn,


	vm=reshape(sim.instrument.allvm(1,i,:),1,sim.T_upd);

	fprintf('Neuron %d  mean=%f\n', i, mm(i));


	subplot(5,1,1);
	plot(vm);
	hold on;

	%
	% spike-train thingies
	%

	[spi, spt, act ]  = calc_spiketrain(vm, sim);
	fprintf('Neuron %d: activity = %d\n', i, act);

	subplot(5,1,1);
	plot(spi,-100,'r*');

	%
	% instantaneous frequency plot
	%
	ifreq = [spi 0] - [0 spi];
	subplot(5,1,2);
%	plot(spi,ifreq(1:length(spi)));
	plot(spi,[0 1000./ifreq(2:length(spi))]);
	hold on;


	%
	% frequency power spectrum
	%
	z=fft(detrend(vm));
	zz=z.*conj(z);
	subplot(5,1,3);
	%plot(20*log(zz(1:100)));
	semilogx(zz(1:100)./max(zz(1:100)));
	hold on;

	%
	% spike ISI 
	%
	% spike correlations
	%
	
	
	end;

subplot(5,1,1); axis([0,sim.T_upd,-100,30]);

return;




figure;
subplot(2,1,1);
plot([inp filter(ones(1,filterlength)/filterlength,1,inp)]);

z=fft(detrend(inp));
zz=z.*conj(z);
subplot(2,1,2);
%plot(20*log(zz(1:100)));
plot(zz(1:100));

inp_amount = -sum(inp)*sim.ts;
inp = sprintf('|I_s| = %.2f\\muAscm^{-2}', inp_amount/1000);
text(0,-10, inp, 'FontSize',[12]);

