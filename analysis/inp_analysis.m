%
% 	input analysis
%
%	$Revision:$
%
function inp_analysis(inp)

fprintf('Input analysis...\n');

N=sim.T_upd;

filterlength = floor(N/10);

used_inp = inp(input_params.start+1:end);
finp = filter(ones(1,filterlength)/filterlength,1,[mean(used_inp(1:filterlength))*ones(filterlength,1); used_inp]);

used_finp = finp(filterlength+1:end);

inp_amount = -mean(used_inp)*sim.ts;
inp_txt = sprintf('|I_s| = %.2f\\muAscm^{-2}', inp_amount);

figure;
subplot(2,1,1);
plot([-used_inp -used_finp]);
text(0,0, inp_txt, 'FontSize',[12]);

z=fft(detrend(inp));
zz=z.*conj(z);
subplot(2,1,2);
%plot(20*log(zz(1:100)));
%plot(zz(1:100));
semilogx(2:100,zz(2:100));
xlabel('frequency [Hz]');
ylabel('Power spectrum');

