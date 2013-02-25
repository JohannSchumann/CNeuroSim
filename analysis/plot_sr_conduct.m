% 	plot_sr_conduct.m
%
%	FN = filename to print (w/o extension)
%	sim: = sim structure 
%	nn_inputs = NN inputs
%	LW = line width for plotting
%	nn_pars: not used
%	off:	temporal offset
%
%	$Revision:$
%
function plot_sr_conduct(FN, sim, nn_inputs, LW, nn_pars, off)

[m_isi, s_isi] =calc_isi_plot(sim, off, 0);

N =sim.N_nn;

colors=['r','g','b'];
%colors=[{'k-'},{'k--'},{'k:'}];
%colors=['kk-','k--','kk:'];
colors=['k- ';'k-.';'k- '];
%colors(1,:)
%colors(2,:)
%colors(3,:)
LWs=[1,1,2]

figure;
i=1;
for nn=1,
	subplot(3,1,i);
	vm=reshape(sim.instrument.allvm(1,nn,1:sim.T_upd),sim.T_upd,1);
	plot(vm(off:end), 'k-', 'Linewidth',LWs(1));
	hold on;
	if (N > 1),
	vm=reshape(sim.instrument.allvm(1,nn+1,1:sim.T_upd),sim.T_upd,1);
	plot(vm(off:end), 'k-.' , 'Linewidth',LWs(2));
	end;
	if (N > 2),
	vm=reshape(sim.instrument.allvm(1,nn+2,1:sim.T_upd),sim.T_upd,1);
	plot(vm(off:end), 'k-', 'Linewidth',LWs(3));
	end;
	axis([0,sim.T_upd-off,-90,40]);
	set(gca,'Visible','off');
	subplot(3,1,i+2);
	plot(-nn_inputs(nn,off:end), 'Linewidth',LW);
	axis([-1,sim.T_upd-off,-3,8]);
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

%text1=sprintf('mu(%s) = [%.2f %.2f %.2f]', sim.exp, ...
%		nn_pars(1), nn_pars(2), nn_pars(3));
%	
%text(0,-5.3,text1,'FontSize',[16]);
subplot(3,1,1);
hold on;
%plot([0,0],[-20,30],'Linewidth',3);
%text(-100,10,'50mV','FontSize',[16]);
%plot([-15,-15],[-20,30],'r', 'Linewidth',3);
%text(-10,10,'50mV','FontSize',[16]);
%text(5,45,'50mV','FontSize',[16]);
text(-50,45,'50mV','FontSize',[16]);
plot([0,0],[-10,40],'r', 'Linewidth',3);

subplot(3,1,3);
hold on;
%plot([0,0],[4,6],'Linewidth',3);
%text(5,5,'2\muA/cm^2','FontSize',[16]);
plot([-1,-1],[-2,-0],'r','Linewidth',3);
%text(5,-1,'2\muA/cm^2','FontSize',[16]);
text(-80,-1,'2\muA/cm^2','FontSize',[16]);

%--------------------------------------------
%axis([1,sim.T_upd-off,0,sim.N_nn+1]);
%set(gca,'Visible','off');
xx=reshape(sim.instrument.allconduct,N,sim.T_upd);

subplot(3,1,2);
for i=1:N,
	fi_conduct=filter(ones(1,5)/5,1,xx(i,:));
%size(fi_conduct)
%	semilogy(abs(fi_conduct(off:end)),colors(i));
	plot(abs(fi_conduct(off:end-10)),colors(i),'LineWidth',LWs(i));
	hold on;

	xxx=abs(fi_conduct(off:end));
%	mean(xxx)
	mean(xxx(find(xxx <0.04)))
	plot(sim.T_upd-off,mean(xxx(find(xxx <0.04))),'r*');
end;

%axis([1,sim.T_upd-off,1e-5,1e2]);
axis([1,sim.T_upd-off,0,0.04]);
ylabel('Conductance [mS/cm^2]');
grid;


subplot(3,1,3);
ti=1:sim.T_upd-off;
y_off_spikes = 6;
for sel=1:N,
        sp=find(sim.instrument.allvm(1,sel,off:end)> sim.activity_thr);
        if (length(sp) > 0),
                spp=zeros(1,length(sp))+y_off_spikes+0.6*sel;
                plot(ti(sp),spp,'r.','MarkerSize',8);
        end;
end;

%--------------------------------------------

fn_eps =sprintf('%s.eps', FN);
print('-deps', fn_eps);
fn_jpg =sprintf('%s.jpg', FN);
print('-djpeg', fn_jpg);
