% 	plot_syn_response_off.m
%
%	with offset
%	3 neurons
%	with identical inputs
%
%	print time line and unit sizes (no axes)
%
%	FN = filename to print (w/o extension)
%	sim: = sim structure 
%	nn_inputs = NN inputs
%	LW = line width for plotting
%
function plot_syn_response_off(FN, sim, nn_inputs, LW, nn_pars, off)

[m_isi, s_isi] =calc_isi_plot(sim, off, 0);

N =sim.N_nn;

figure;
i=1;
for nn=1,
	subplot(3,1,i);
	vm=reshape(sim.instrument.allvm(1,nn,1:sim.T_upd),sim.T_upd,1);
	plot(vm(off:end), 'b', 'Linewidth',LW);
	hold on;
if (N > 1),
	vm=reshape(sim.instrument.allvm(1,nn+1,1:sim.T_upd),sim.T_upd,1);
	plot(vm(off:end), 'r', 'Linewidth',LW);
end;
if (N > 2),
	vm=reshape(sim.instrument.allvm(1,nn+2,1:sim.T_upd),sim.T_upd,1);
	plot(vm(off:end), 'g', 'Linewidth',LW);
end;
	axis([0,sim.T_upd-off,-90,40]);
	set(gca,'Visible','off');
	subplot(3,1,i+2);
	plot(-nn_inputs(nn,off:end), 'Linewidth',LW);
	axis([0,sim.T_upd-off,-3,8]);
	set(gca,'Visible','off');
	i=i+2;
	end;

subplot(3,1,3);
hold on;

plot([0,sim.T_upd-off],[-2.5,-2.5],'Linewidth',LW);
for i=0:50:sim.T_upd-off,
	plot([i,i],[-2.6,-2.1],'Linewidth',2);
	end;
plot([sim.T_upd-50-off, sim.T_upd],[-2.9,-2.9],'Linewidth',2);
text(sim.T_upd-50-off,-5.3,'50ms','FontSize',[16]);

text1=sprintf('mu(%s) = [%.2f %.2f %.2f]', sim.exp, ...
		nn_pars(1), nn_pars(2), nn_pars(3));
	
text(0,-5.3,text1,'FontSize',[16]);

subplot(3,1,1);
hold on;
plot([0,0],[-20,30],'Linewidth',3);
%text(5,10,'50mV','FontSize',[16]);
text(-100,10,'50mV','FontSize',[16]);

subplot(3,1,3);
hold on;
plot([0,0],[4,6],'Linewidth',3);
text(5,5,'2\muA/cm^2','FontSize',[16]);

%--------------------------------------------
subplot(3,1,2);
ti=1:sim.T_upd-off;
hold off;
for i=1:sim.N_nn,
        sp=find(sim.instrument.allvm(1,i,off:end) > sim.activity_thr);
        if (length(sp) > 0),
                spp=zeros(1,length(sp))+sim.N_nn-i+1;
                plot(ti(sp),spp,'.','MarkerSize',8);
		hold('on');
        end;
	n_fire = sprintf('%3d',...
	   neuron_activity(sim.instrument.allvm(1,i,:),off,sim));
	text(sim.T_upd-off,sim.N_nn-i+1,n_fire, 'FontSize',[12]);

	text_isi = sprintf('I=%.1f[%.1f]', m_isi(i), s_isi(i));
	text(-130,sim.N_nn-i+1,text_isi, 'FontSize',[12]);
        end;
hold off;
axis([1,sim.T_upd-off,0,sim.N_nn+1]);
set(gca,'Visible','off');

subplot(3,1,3);
sel=1;
        sp=find(sim.instrument.allvm(1,sel,off:end)> sim.activity_thr);
        if (length(sp) > 0),
                spp=zeros(1,length(sp))+3;
                plot(ti(sp),spp,'r.','MarkerSize',8);
        end;

%--------------------------------------------

fn_eps =sprintf('%s.eps', FN);
print('-deps', fn_eps);
fn_jpg =sprintf('%s.jpg', FN);
print('-djpeg', fn_jpg);
