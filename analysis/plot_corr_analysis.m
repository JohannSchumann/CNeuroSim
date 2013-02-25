%
% 	generate correlated input and plot analysis and explanation
%
%	$Revision:$
%

function plot_corr_analysis(FN, all_nn_inputs, sim)


figure;

for r=1:3,
	idx=1+(r-1)*4;
	
	subplot(3,3,r);
	
	for i=1:10,
		plot([i*(idx-1),i*(idx-1)+5],[i,i], 'LineWidth', 5);
		hold on;
		end;
	axis([0, 100,  -1, 11]);
	ylabel('Superposition');
	%set(gca,'Visible','off');

	subplot(3,3,3+r);

	plot(all_nn_inputs(idx,:));
	axis([0,1000,-0.1,5])
	%set(gca,'Visible','off');
	ylabel('I_s');
	xlabel('t[ms]');

	subplot(3,3,6+r);
%	z=fft(detrend(all_nn_inputs(idx,:)));
	z=fft(detrend(all_nn_inputs(idx,:)./mean(all_nn_inputs(idx,:))));
	zz=z.*conj(z);
%	semilogx(2:100,zz(2:100));
	semilogx(2:50,zz(2:50));
	xlabel('frequency [Hz]');
	ylabel('Power spectrum');
	axis([2,60,0,2e5]);

	end;

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



