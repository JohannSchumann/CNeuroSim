%	Plot results of simulation into gui axes
%
%	$Revision:$
%
function plot_results(handles, sim, nn_inputs)


zoom=sim.gui.zoom;
N=sim.T_upd;

	% sim.pos is 0..1 relative
pos=sim.gui.pos*N;

%
% disable position for now
%
pos=0;

off=1;

LW=1;

%
% calculate the range to display
%
XLB=pos;
XUB=(N-pos)/zoom;

% input signal

axes(handles.axes1);
%--------------------------
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
%axis([-10,sim.T_upd-off,maxp,minp]);
%set(gca,'Visible','off');
%set(gca,'Color','none','Xtick',[]);
%axis([XLB, XUB, inputdata.minmax(1)-0.2,inputdata.minmax(2)+0.2]);
axis([XLB, XUB, maxp,minp]);
%--------------------------

% subthreshold oscillation
%
%axes(handles.axes2);
%plot(sim.timeline,neurondata.subthr_osc);
%axis([XLB, XUB,-20,20]);

% membrane potential

axes(handles.axes3);
if (sim.gui.hold_V_membr == 1)
	hold on;
end;

%-----------------------------
LW=1;
col=['b','r','g','m','c','k','y'];
for i = 1:sim.N_nn,
    vm=reshape(sim.instrument.allvm(1,i,1:sim.T_upd),sim.T_upd,1);
    plot(vm(off:end), col(:,mod(i,7)+1), 'Linewidth',LW);
    hold on;
    end;


if (1==0),
	hold on;
        axis([-10,sim.T_upd-off,-90,40]);
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
%set(gca,'Visible','off');
%set(gca,'Color','none','Xtick',[]);
%ylabel('V_m[mV]');

%-----------------------------
%axis([XLB, XUB,-90,40]);
axis([XLB, XUB,-90,40]);
hold off;

% spiking

axes(handles.axes4);

if (1==0),
	%plot(sim.timeline,spikedata.spikes);
	%axis([XLB, XUB,0,1.1]);
	
	fprintf('spikes =%f\n', sum(sum(spikes)));
	
	hold(handles.axes4,'off');
	%hold off;
	cla;
	for i=1:sim.max_neuron,
		sp=find(spikes(i,:)==1);
		if (length(sp) > 0),
			spp=zeros(1,length(sp))+i;
			plot(sim.timeline(sp),spp,'.','MarkerSize',8);
		%	plot(sim.timeline(find(spikes(i,:)>0)),0.1*i,'x');
			hold(handles.axes4,'on');
		end;
		end;
	hold(handles.axes4,'off');
	
	axis([XLB, XUB,0,1*sim.max_neuron+2]);
end;
	

% additional figures

if (1==0),
if (sim.plot_alpha == 1)
	figure(1);
	plot(sim.timeline,neurondata.alpha_save);
	axis([XLB, XUB,0,1]);
end;

if (sim.plot_gamma == 1)
	figure(2);
	plot(sim.timeline,neurondata.gamma_save);
	axis([XLB, XUB, ...
	    min(neurondata.gamma_save)-0.5,max(neurondata.gamma_save)+0.5]);
end;
end;

