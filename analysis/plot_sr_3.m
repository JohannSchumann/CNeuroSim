% 	plot syn_response figure for selected neurons
%
%	print time line and unit sizes (no axes)
%
%	FN = filename to print (w/o extension)
%	sim: = sim structure 
%	nn_inputs = NN inputs
%	LW = line width for plotting
%	off: temporal offset
%	sel: selection of neurons (list of indices)
%
%	$Revision:$
%
function plot_sr_3(FN, sim, nn_inputs, LW, nn_pars, off,sel)

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


N =sim.N_nn;

x_val= -120*(sim.T_upd/1000);

figure;

%------------------------------------------------------------------
% plot VM for 1,2,or 3 neurons
%------------------------------------------------------------------
	subplot(4,1,1);
	vm=reshape(sim.instrument.allvm(1,sel(1),1:sim.T_upd),sim.T_upd,1);
	plot(vm(off:end), 'b', 'Linewidth',LW);
	axis([0,sim.T_upd-off,-90,40]);
if (N > 1),
	subplot(4,1,2);
	vm=reshape(sim.instrument.allvm(1,sel(2),1:sim.T_upd),sim.T_upd,1);
	plot(vm(off:end), 'b', 'Linewidth',LW);
	axis([0,sim.T_upd-off,-90,40]);
	set(gca,'Visible','off');
end;
if (N > 2),
	subplot(4,1,3);
	vm=reshape(sim.instrument.allvm(1,sel(3),1:sim.T_upd),sim.T_upd,1);
	plot(vm(off:end), 'b', 'Linewidth',LW);
	axis([0,sim.T_upd-off,-90,40]);
	set(gca,'Visible','off');
end;

subplot(4,1,1);
hold on;
plot([0,0],[-20,30],'Linewidth',3);
text(x_val,10,'50mV','FontSize',[16]);
%text(x_val,-70,'V_m','FontSize',[16]);
set(gca,'Visible','off');

%------------------------------------------------------------------
% plot Input
%------------------------------------------------------------------
subplot(4,1,4);

	%
	% Input
	%
%plot(-nn_inputs(1,off:end), 'Linewidth',LW);
%if (1==1),
%	hold on;
	plot(-nn_inputs(1,off:end)-nn_inputs(2,off:end), 'r', 'Linewidth',LW);
%	end;
minp = max(-nn_inputs(1,off:end));
axis([0,sim.T_upd-off,-3,minp]);
set(gca,'Visible','off');

rs=minp/8;

hold on;
text(x_val,0,'I_s','FontSize',[16]);

	%
	% time-line
	%
%plot([0,sim.T_upd-off],[-2.5,-2.5],'Linewidth',LW);
%for i=0:50:sim.T_upd-off,
%	plot([i,i],[-2.6,-2.1],'Linewidth',2);
%	end;
plot([sim.T_upd-50-off, sim.T_upd],[-2.9,-2.9],'Linewidth',2);
text(sim.T_upd-50-off,-5.3,'50ms','FontSize',[16]);
plot([sim.T_upd-off, sim.T_upd-off],-2.9+rs*[0,10],'Linewidth',3);
text(sim.T_upd-off+10,-2.9+rs*5,'\muAcm^{-2}','FontSize',[16]);

	%
	% integrated input
	%
if (1==0),
inp_amount = -sum(nn_inputs(1,off:end))*sim.ts;
inp = sprintf('|I_s| = %.2f\\muAscm^{-2}', inp_amount/sim.T_upd);
text(0,-6.3, inp, 'FontSize',[12]);
end;

	%
	% mu parameters -now obsolete
	%
%if (nn_pars(1:3) ~= [0;0;0]),
%	text1=sprintf('mu(%s) = [%.2f %.2f %.2f]', sim.exp, ...
%		nn_pars(1), nn_pars(2), nn_pars(3));
%	
%	text(300,-5.3*rs,text1,'FontSize',[12]);
%	end;
%

	%
	% Input scaling
	%
if (1 == 0),
	hold on;
	plot([0,0],rs*[0,10],'Linewidth',3);
	%text(5,5,'10\muA/cm^2','FontSize',[16]);
	%text(x_val,0,'I_s','FontSize',[16]);
	text(-120,rs*5,'2\muAcm^{-2}','FontSize',[16]);
	text(x_val,-2,'I_s','FontSize',[16]);
	end;
	
if (1 == 0),
	hold on;
	plot([0,0],rs*[0,10],'Linewidth',3);
	text(x_val,rs*5,'\muAcm^{-2}','FontSize',[16]);
% 10???
%	text(x_val,-2,'I_s','FontSize',[16]);
	end;
	
%------------------------------------------------------------------
% print rasterplot
%------------------------------------------------------------------
if (1==0),
subplot(4,1,2);
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
	n_fire = sprintf('%3.1dHz',...
	   1000*neuron_activity(sim.instrument.allvm(1,i,:),off,sim)/ ...
		(sim.T_upd-off+1));
	text(sim.T_upd-off,sim.N_nn-i+1,n_fire, 'FontSize',[12]);

		%
		% ISI and sigma^2
		%
	text_isi = sprintf('I=%.1f[%.1f]', m_isi(i), s_isi(i));
	text(1.3*x_val,sim.N_nn-i+1,text_isi, 'FontSize',[12]);

%	n_fire = sprintf('%3.1d',...
%	   neuron_activity(sim.instrument.allvm(1,i,:),off,sim));
%	text(-130,sim.N_nn-i+1,n_fire, 'FontSize',[16]);

        end;
hold off;
axis([1,sim.T_upd-off,0,sim.N_nn+1]);
set(gca,'Visible','off');

end;


%------------------------------------------------------------------
% print Ca_i and iAHP
%------------------------------------------------------------------
if (1==0),
subplot(4,1,4);

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

end;

%------------------------------------------------------------------
% print iAHP
%------------------------------------------------------------------
if (1==0),
subplot(4,1,5);
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
