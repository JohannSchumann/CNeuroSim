% 	plot phase-plane
%	FN: file to save
%	sim: sim data structure
%	off: temporal offset
%

function plot_phaseplane(FN, sim, offset)

figure;

co=['b.';'g.';'r.';'c.';'m.';'y.';'k.'];

for i=1:sim.N_nn,
	dv=sim.instrument.I_Channels(i).dV_m;
	vm=reshape(sim.instrument.allvm(1,i,1:sim.T_upd-1),sim.T_upd-1,1);
	plot(vm,dv,co(i,:));
	hold on;
	end;

%axis([0,sim.T_upd-off,-3,minp]);
%set(gca,'Visible','off');
%
%text(sim.T_upd-50-off,-5.3,'50ms','FontSize',[16]);
xlabel('V_m [mV]');
ylabel('dV_m/dt [mV/ms]');
title('Phase diagram');

%------------------------------------------------------------------
% print the stuff to file
%------------------------------------------------------------------
fn_eps =sprintf('%s_php.eps', FN);
print('-depsc', fn_eps);
fn_jpg =sprintf('%s_php.jpg', FN);
print('-djpeg', fn_jpg);
