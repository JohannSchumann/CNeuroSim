%
%	plot a figure on the gains
%
%	$Revision:$

%	inp_dc = [zeros(size(inp_dc,1)) inp_dc];
%	out_freq= [ zeros(N_gain_inp,1) out_freq];
%	out_freq_ss= [ zeros(N_gain_inp,1) out_freq_ss];
	theinput = [zeros(size(inp_mean,2),1) inp_mean'];
	mout_freq= [ zeros(size(out_freq,2),1) out_freq'];
	mout_freq_ss= [ zeros(size(inp_mean,1)) out_freq_ss];

if (sim.nA_units),
	theinput = theinput * sim.nA;
	end;

figure
col=get(gca,'ColorOrder');
markers=['o','s','d','^','v','<','>','p','h'];
for i=1:sim.N_nn,
        [a,b]=sort(theinput(i,:));
        plot(-theinput(i,b),mout_freq(i,b)', 'Marker', markers(i), ...
		'Linewidth', 1.5, 'Color', col(i,:));
        hold on;
        end;
if (nA_units),
	xlabel('Input magnitude [nA]', 'FontSize', [16]);
else
	xlabel('Input magnitude [\muAscm^{-2}]', 'FontSize', [16]);
end;
ylabel('Firing rate [Hz]', 'FontSize', [16]);
%axis([0,3,0,50]);
%legend({ sprintf('%.1f',thispar(1)), 
%         sprintf('%.1f',thispar(2)), 
%	 sprintf('%.1f',thispar(3)), 
%         sprintf('%.1f',thispar(4)), 
%         sprintf('%.1f',thispar(5))} ...
% , 'Location','SouthEast');
%%legend({ 'N1', 'N2', 'N3', 'N4', 'N5'} ...
%% , 'Location','NorthWest');

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


