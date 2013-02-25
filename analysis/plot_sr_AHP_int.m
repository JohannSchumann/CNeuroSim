%
%	1..3 neurons
%	print time line and unit sizes (no axes)
%
%	FN = filename to print (w/o extension)
%	sim: = sim structure 
%	nn_inputs = NN inputs
%	LW = line width for plotting
%
%	$Revision:$
%
function plot_sr_AHP_int(FN, sim, nn_inputs, LW, nn_pars, off)

	%
	% bugfix for wrong sim.instrument.spiketrain
	%
for i=1:sim.N_nn,
	[spi, spt,act ] = ...
	  calc_spiketrain(reshape(sim.instrument.allvm(1,i,off:end),1,sim.T_upd-off+1), sim);


	iisi = [spi sim.T_upd] - [0 spi];
	m_isi(i) = mean(iisi(2:end-1));
	s_isi(i) = std(iisi(2:end-1));
	end;

%[m_isi, s_isi] =calc_isi_plot(sim, off, 0);

N =sim.N_nn;

x_val= -120*(sim.T_upd/1000);

figure;

%------------------------------------------------------------------
% plot VM for 1,2,or 3 neurons
%------------------------------------------------------------------
subplot(3,1,3);
vm=reshape(sim.instrument.allvm(1,1,1:sim.T_upd),sim.T_upd,1);
plot(vm(off:end), 'b', 'Linewidth',LW);
hold on;
if (N > 1),
	vm=reshape(sim.instrument.allvm(1,2,1:sim.T_upd),sim.T_upd,1);
	plot(vm(off:end), 'r', 'Linewidth',LW);
end;
if (N > 2),
	vm=reshape(sim.instrument.allvm(1,3,1:sim.T_upd),sim.T_upd,1);
	plot(vm(off:end), 'g', 'Linewidth',LW);
end;

axis([-10,sim.T_upd-off,-90,40]);
hold on;

if (1==1),
	% left axis
	plot([-10,-10],[-80,20],'k','Linewidth',2);
	plot([-0,-10],[-80,-80],'k','Linewidth',2);
	text(-60,-80,'-80','FontSize',[12]);
	plot([-0,-10],[-60,-60],'k','Linewidth',2);
	text(-60,-60,'-60','FontSize',[12]);
	plot([-0,-10],[-40,-40],'k','Linewidth',2);
	text(-60,-40,'-40','FontSize',[12]);
	plot([-0,-10],[-20,-20],'k','Linewidth',2);
	text(-60,-20,'-20','FontSize',[12]);
	plot([-0,-10],[-0,-0],'k','Linewidth',2);
	text(-37,-0,'0','FontSize',[12]);
	plot([-0,-10],[20,20],'k','Linewidth',2);
	text(-50,20,'20','FontSize',[12]);
	text(-50,-105,'V_m[mV]','FontSize',[12]);
end;


if (1==0),
	plot([0,0],[-20,30],'Linewidth',3);
	text(x_val,10,'50mV','FontSize',[16]);
	text(x_val,-70,'V_m','FontSize',[16]);
end;
set(gca,'Visible','off');
set(gca,'Color','none','Xtick',[]);
ylabel('V_m[mV]');

%------------------------------------------------------------------
% plot Input
%------------------------------------------------------------------
subplot(3,1,1);

    theinput = (-nn_inputs(1,off:end)-nn_inputs(2,off:end));
    y_fact=1;
    if (sim.nA_units == 1),
	    theinput = theinput*sim.nA;
	    y_fact = sim.nA;
    end;

	%
	% Input
	%
	plot(theinput, 'r', 'Linewidth',LW);

hold on;
minp = max(theinput);
maxp = min(theinput);
axis([-10,sim.T_upd-off,maxp,minp]);
set(gca,'Visible','off');
set(gca,'Color','none','Xtick',[]);

rs=minp/8;

hold on;
if (1==0),
	text(sim.T_upd-off -40,minp-y_fact*0.2,'I_s','FontSize',[16]);
else
	%
	% integrated input
	%
    inp_amount = (-sum(nn_inputs(1,off:end)) -sum(nn_inputs(2,off:end)))*sim.ts;

    if (sim.nA_units == 1),
	    inp = sprintf('|I_s| = %.2fnA', inp_amount*sim.nA/sim.T_upd);
            ylabel('I_s[nA]');
	    yl='I_s[nA]';
	else
            inp = sprintf('|I_s| = %.2f\\muAscm^{-2}', inp_amount/sim.T_upd);
            ylabel('I_s[\muAcm^{-2}]');
            yl='I_s[\muAcm^{-2}]';
	end;
	text(sim.T_upd-off -140,minp-y_fact*0.5,inp,'FontSize',[12]);
end;

	%
	% time-line
	%
if (1==0),
	plot([0,sim.T_upd-off],[-2.5,-2.5],'Linewidth',LW);
	for i=0:50:sim.T_upd-off,
		plot([i,i],[-2.6,-2.1],'Linewidth',2);
		end;
end;
plot([sim.T_upd-50-off, sim.T_upd],[maxp+0,maxp+0],'Linewidth',2);
text(sim.T_upd-50-off,maxp-y_fact*0.4,'50ms','FontSize',[12]);

if (1==1),
	% left axis
	plot([-9,-9],[maxp, minp],'k','Linewidth',2);

	N_YTicks=7;
	dy=(minp - maxp)/(N_YTicks-1);
	for i=1:N_YTicks,
		YTick=maxp+(i-1)*dy;
		plot([-0,-10],[YTick, YTick],'k','Linewidth',2);
		text(-60,YTick,sprintf('%.1f',YTick),'FontSize',[12]);
		end;
%	text(-60,maxp,sprintf('%.1f',maxp),'FontSize',[12]);
%	text(-60,minp,sprintf('%.1f',minp),'FontSize',[12]);
%	plot([-0,-10],[maxp, maxp],'k','Linewidth',2);
%	plot([-0,-10],[minp, minp],'k','Linewidth',2);

	text(-50,maxp-0.8*y_fact,yl,'FontSize',[12]);
end;


%------------------------------------------------------------------
% print dots for selected neuron into input
%------------------------------------------------------------------
if (1==0),
	subplot(3,1,1);
	sel=1;
        sp=find(sim.instrument.allvm(1,sel,off:end)> sim.activity_thr);
        if (length(sp) > 0),
                spp=zeros(1,length(sp))+3;
                plot(ti(sp),spp,'r.','MarkerSize',8);
        	end;
	end;


%------------------------------------------------------------------
% print rasterplot
%------------------------------------------------------------------
subplot(3,1,2);
ti=1:sim.T_upd-off+5;
hold off;
for i=1:sim.N_nn,
        sp=find(sim.instrument.allvm(1,i,off:end) > sim.activity_thr);
        if (length(sp) > 0),
                spp=zeros(1,length(sp))+sim.N_nn-i+1;
                plot(ti(sp),spp,'.','MarkerSize',8);
		hold('on');
        end;

		%
		% activity rate [Hz]
		%
	n_fire = sprintf('%2.2dHz',...
	   floor(1000*neuron_activity(sim.instrument.allvm(1,i,off:sim.T_upd),1,sim)/ ...
		(sim.T_upd-off+1)));
	text(sim.T_upd-off+5,sim.N_nn-i+1,n_fire, 'FontSize',[12]);

		%
		% ISI and sigma^2
		%
%	text_isi = sprintf('I=%.1f[%.1f]', m_isi(i), s_isi(i));
	text_isi = sprintf('ISI %.1f', m_isi(i));
%	text(1.3*x_val,sim.N_nn-i+1,text_isi, 'FontSize',[12]);
%	text(sim.T_upd-off,sim.N_nn-i, text_isi, 'FontSize',[12]);

%	n_fire = sprintf('%3.1d',...
%	   neuron_activity(sim.instrument.allvm(1,i,:),off,sim));
%	text(-130,sim.N_nn-i+1,n_fire, 'FontSize',[16]);

        end;
hold off;
axis([1,sim.T_upd-off,0,sim.N_nn+1]);
set(gca,'Visible','off');


if (1==0),
%------------------------------------------------------------------
% print Ca_i and iAHP
%------------------------------------------------------------------
subplot(5,1,4);

if (sim.display.channels.Cai == 1),
  cai=sim.instrument.I_Channels(1).Cai;
  plot(cai(off:end), 'b', 'Linewidth',LW);
  hold on;
  if (N > 1),
	cai=sim.instrument.I_Channels(2).Cai;
	plot(cai(off:end), 'r', 'Linewidth',LW);
  end;
  if (N > 2),
	cai=sim.instrument.I_Channels(3).Cai;
	plot(cai(off:end), 'g', 'Linewidth',LW);
  end;
  text(x_val,0,'Ca_i','FontSize',[16]);
end;

if (sim.display.channels.NMDA == 1),
  nmda=-sim.instrument.I_Channels(1).I_NMDA;
  plot(nmda(off:end), 'b', 'Linewidth',LW);
  hold on;
  if (N > 1),
	nmda=-sim.instrument.I_Channels(2).I_NMDA;
	plot(nmda(off:end), 'r', 'Linewidth',LW);
  end;
  if (N > 2),
	nmda=-sim.instrument.I_Channels(3).I_NMDA;
	plot(nmda(off:end), 'g', 'Linewidth',LW);
  end;
  text(x_val,0,'I_{NMDA}','FontSize',[16]);
end;


set(gca,'Visible','off');

%------------------------------------------------------------------
% print iAHP
%------------------------------------------------------------------
subplot(5,1,5);
iahp=sim.instrument.I_Channels(1).I_AHP;
plot(iahp(off:end), 'b', 'Linewidth',LW);
hold on;
mx=max(iahp);
if (N > 1),
%	iahp=reshape(sim.instrument.I_Channels.I_AHP(2,1:sim.T_upd),sim.T_upd,1);
	iahp=sim.instrument.I_Channels(2).I_AHP;
	plot(iahp(off:end), 'r', 'Linewidth',LW);
	mx=max(mx,max(iahp));
end;
if (N > 2),
%	iahp=reshape(sim.instrument.I_Channels.I_AHP(3,1:sim.T_upd),sim.T_upd,1);
	iahp=sim.instrument.I_Channels(3).I_AHP;
	plot(iahp(off:end), 'g', 'Linewidth',LW);
	mx=max(mx,max(iahp));
end;


text(x_val,0,'I_{AHP}','FontSize',[16]);

% hold on;
% plot([0,0],[mx,mx-1],'Linewidth',3);
% text(-120,mx,'2\muAcm^{-2}','FontSize',[16]);

set(gca,'Visible','off');

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
print('-dpng','-r150', fn_png);

