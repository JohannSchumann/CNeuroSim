% 	plot individual channels
%		for 1 neuron
%
%	FN:	filename for output file
%	sim	sim data structure
%	nn_inputs:	input data
%	params:		not used
%	is_hold:	if 1: add to existing figure in color red
%
function plot_sr_channels(FN, sim, nn_inputs, params, is_hold)


if (is_hold == 0),
	figure;
	color = 'b';
else
	hold on;
	color = 'r';
end;

NF=5;
LW=1;
off = sim.offset;
txt_xval = -100*(sim.T_upd/1000);
%------------------------------------------------------------------
% plot VM 
%------------------------------------------------------------------
subplot(NF,1,1);
vm=reshape(sim.instrument.allvm(1,1,1:sim.T_upd),sim.T_upd,1);
plot(vm(off:end), color , 'Linewidth',LW);

axis([0,sim.T_upd-off,-90,40]);
hold on;
plot([0,0],[-20,30],'Linewidth',3);
text(txt_xval,10,'50mV','FontSize',[16]);
text(txt_xval,-70,'V_m','FontSize',[16]);
set(gca,'Visible','off');

%------------------------------------------------------------------
% plot Input
%------------------------------------------------------------------
subplot(NF,1,NF);
plot(-nn_inputs(1,off:end), 'Linewidth',LW);
minp = max(-nn_inputs(1,off:end));
axis([0,sim.T_upd-off,-3,minp]);
set(gca,'Visible','off');


hold on;

%sel=1;
%sp=find(sim.instrument.allvm(1,sel,off:end)> sim.activity_thr);
%if (length(sp) > 0),
%        spp=zeros(1,length(sp))+3;
%        plot(ti(sp),spp,'r.','MarkerSize',8);
%        end;


if (is_hold == 0),
	rs=minp/8;
	plot([0,0],rs*[4,6],'Linewidth',3);
	text(-120,rs*5,'2\muAcm^{-2}','FontSize',[16]);
	text(txt_xval,-2,'I_s','FontSize',[16]);
	plot([0,sim.T_upd-off],[-2.5,-2.5],'Linewidth',LW);
	for i=0:50:sim.T_upd-off,
		plot([i,i],[-2.6,-2.1],'Linewidth',2);
		end;
	plot([sim.T_upd-50-off, sim.T_upd],[-2.9,-2.9],'Linewidth',2);
	text(sim.T_upd-50-off,-5.3,'50ms','FontSize',[16]);

	inp_amount = -mean(nn_inputs(1,off:end))*sim.ts;
	inp = sprintf('|I_s| = %.2f\\muAscm^{-2}', inp_amount);
	text(0,-7.3*rs, inp, 'FontSize',[12]);
end;

%------------------------------------------------------------------
% print various channels
% !!!!!!! neuron 1 only !!!
%------------------------------------------------------------------
subplot(NF,1,2);
plot(sim.instrument.I_Channels(1).I_CaL(off:end), color, 'Linewidth',LW);
hold on;
text(txt_xval,0,'I_{CaL}','FontSize',[16]);
%set(gca,'Visible','off');

subplot(NF,1,3);
plot(sim.instrument.I_Channels(1).Cai(off:end), color, 'Linewidth',LW);
hold on;
text(txt_xval,0,'Cai','FontSize',[16]);

cai_amount = -mean(nn_inputs(1,off:end))*sim.ts;
cai_txt = sprintf('|I_{Cai}| = %.2f\\muAscm^{-2}', cai_amount);
text(0,0, cai_txt, 'FontSize',[12]);

subplot(NF,1,4);
plot(sim.instrument.I_Channels(1).I_AHP(off:end), color, 'Linewidth',LW);
hold on;
text(txt_xval,0,'I_{AHP}','FontSize',[16]);


%------------------------------------------------------------------
% print the stuff to file
%------------------------------------------------------------------
fn_eps =sprintf('%s.eps', FN);
print('-deps', fn_eps);
fn_jpg =sprintf('%s.jpg', FN);
print('-djpeg', fn_jpg);
