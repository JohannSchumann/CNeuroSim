% 	plot_sr_conduct_g.m
%
%	FN = filename to print (w/o extension)
%	sim: = sim structure 
%	nn_inputs = NN inputs
%	LW = line width for plotting
%
%	$Revision:$
%
function plot_syn_response_off(FN, sim, nn_inputs, LW, nn_pars, off)


use_linscale=1;


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
	vm=reshape(sim.instrument.allvm(1,nn+1,1:sim.T_upd),sim.T_upd,1);
	plot(vm(off:end), 'k-.' , 'Linewidth',LWs(2));
	vm=reshape(sim.instrument.allvm(1,nn+2,1:sim.T_upd),sim.T_upd,1);
	plot(vm(off:end), 'k-', 'Linewidth',LWs(3));
%	axis([0,sim.T_upd-off,-90,40]);
	axis([-10,sim.T_upd-off,-90,40]);
	set(gca,'Visible','off');
	subplot(3,1,i+2);
	plot(-nn_inputs(nn,off:end), 'Linewidth',LW);
%current	axis([-1,sim.T_upd-off,-3,8]);
%	axis([-1,sim.T_upd-off,-0.1,0.1]);
	axis([-10,sim.T_upd-off,-0.1,0.1]);
	set(gca,'Visible','off');
	i=i+2;
	end;

subplot(3,1,3);
hold on;

plot([0,sim.T_upd-off],[-0.08,-0.08],'Linewidth',LW);
for i=0:50:sim.T_upd-off,
	plot([i,i],[-0.09,-0.07],'Linewidth',2);
	end;
plot([sim.T_upd-50-off, sim.T_upd],[-0.095,-0.095],'Linewidth',2);
text(sim.T_upd-50-off,-0.15,'50ms','FontSize',[16]);

subplot(3,1,1);
hold on;
text(-24,-5,'50mV','FontSize',[16], 'Rotation', 90);
%plot([0,0],[-10,40],'r', 'Linewidth',3);
plot([-7,-7],[-10,40],'r', 'Linewidth',3);


subplot(3,1,3);
hold on;
%plot([-1,-1],[-0.1,0],'r','Linewidth',3);
plot([-7,-7],[-0.05,0],'r','Linewidth',3);
text(-24,-0.05,'.05mS/cm^2','FontSize',[16], 'Rotation', 90);

%--------------------------------------------
%axis([1,sim.T_upd-off,0,sim.N_nn+1]);
%set(gca,'Visible','off');
xx=reshape(sim.instrument.allconduct,3,sim.T_upd);

subplot(3,1,2);
for i=1:3,
	fi_conduct=filter(ones(1,5)/5,1,xx(i,:));
%size(fi_conduct)
%	semilogy(abs(fi_conduct(off:end)),colors(i));
if(use_linscale),
	plot(abs(fi_conduct(off:end-10)),colors(i),'LineWidth',LWs(i));
else
	semilogy(abs(fi_conduct(off:end-10)),colors(i),'LineWidth',LWs(i));
end;
	hold on;

	xxx=abs(fi_conduct(off:end));
%	mean(xxx)
	mean(xxx(find(xxx <0.04)))
%MEAN	plot(sim.T_upd-off,mean(xxx(find(xxx <0.04))),'r*');
end;


if (use_linscale),
	axis([-10,sim.T_upd-off,0,0.04]);
else
%LOG1 axis([-10,sim.T_upd-off,0,5]);
	axis([-10,sim.T_upd-off,0,1]);
end;
ylabel('mS/cm^2','FontSize',[16]);
set(gca,'FontSize',[16]);
%JSC 3/2006
% grid;
%JSC 3/2006
set(gca,'Visible','off');

hold on;
%%%% LINSCALE
if(use_linscale),
	%text(-24,0.02,'.04mS/cm^2','FontSize',[16], 'Rotation', 90);
	%plot([-7,-7],[0.00,0.04],'r', 'Linewidth',3);

	plot([-3,-3],[0.00,0.04],'r', 'Linewidth',1);
	plot([-8,-3],[0.00,0.00],'r', 'Linewidth',1);
	plot([-8,-3],[0.04,0.04],'r', 'Linewidth',1);
	text(-18,0.00,'0','FontSize',[12]);
	text(-40,0.04,'0.04','FontSize',[12]);
	text(-24,0.01,'mS/cm^2','FontSize',[16], 'Rotation', 90);
else
	plot([-3,-3],[0.001,1],'r', 'Linewidth',1);
	plot([-8,-3],[0.1,0.1],'r', 'Linewidth',1);
	plot([-8,-3],[0.01,0.01],'r', 'Linewidth',1);
	plot([-8,-3],[0.001,0.001],'r', 'Linewidth',1);
	plot([-8,-3],[1,1],'r', 'Linewidth',1);
	text(-35,0.001,'10^-3','FontSize',[12]);
	text(-35,0.01,'10^-2','FontSize',[12]);
	text(-35,1,'1','FontSize',[12]);
	text(-35,0.1,'0.1','FontSize',[12]);
	text(-48,0.001,'mS/cm^2','FontSize',[16], 'Rotation', 90);
end;

subplot(3,1,3);
ti=1:sim.T_upd-off;
y_off_spikes = 2;
y_off_spikes = 5;
y_off_spikes = 6;

y_off_spikes = 0.05;
for sel=1:3,
        sp=find(sim.instrument.allvm(1,sel,off:end)> sim.activity_thr);
        if (length(sp) > 0),
                spp=zeros(1,length(sp))+y_off_spikes+0.01*sel;
                plot(ti(sp),spp,'r.','MarkerSize',8);
        end;
end;

%--------------------------------------------

fn_eps =sprintf('%s.eps', FN);
print('-deps', fn_eps);
fn_jpg =sprintf('%s.jpg', FN);
print('-djpeg', fn_jpg);
