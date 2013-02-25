%
%
% 	Plotting channel current for Kir, KAs over V_m
%	Vm over mS/cm^2
%
%	$Revision:$
%
clear;
V_m=-100:1:50;
V_m=-100:1:20;

N=length(V_m);


for i=1:N,
	v_m=V_m(i);
	[ii,dm, dh ,m,h] = ikas(v_m,0,0);  % extract minf, hinf
	I_KAs(i) =ikas(v_m,m,h)/(v_m - -85);
	[ii, dm, m] = ikir(v_m,0);  % extract minf, hinf
	I_Kir(i) =ikir(v_m,m)/(v_m - -90);
	[ii,dm, dh ,m,h] = ical(v_m,0,0);  % extract minf, hinf
	I_CaL(i) =ical(v_m,m,h)/(v_m - 140);
end;

figure;
hold off;
%plot(V_m, I_KAs, 'Linewidth', 2);
%hold on;
%plot(V_m, I_Kir, 'Linewidth', 2);
%%plot(V_m, I_CaL, 'Linewidth', 2);

for i=[0.6,0.8,1.0,1.2,1.4];
	plot(i*I_KAs, V_m, '-');
	hold on;
	plot(i*I_Kir, V_m, '-');
	plot(i*I_CaL, V_m, '-');
	end;
set(gca,'FontSize',[20]);
%xlabel('V_m [mV]');
%ylabel('I [\mu A/cm^2]');

text(0.02,-70,'Kir','FontSize',[20]);
text(0.004,-50, 'IAs','FontSize',[20]);
text(0.012,-28, 'CaL','FontSize',[20]);

axis([0,0.04,-80,-20]);
ylabel('mV');
xlabel('mS/cm^2');

%print -deps vm_I_Kir_KAs.eps;
%print -djpeg vm_I_Kir_KAs.jpg;
print -deps gC_vm_Kir_KAs_CaL.eps;
print -djpeg gC_vm_Kir_KAs_CaL.jpg;

if (1==0),
figure;
hold off;

for i=[0.6,0.8,1.0,1.2,1.4];
	plot(-i*I_KAs, V_m, '-');
	hold on;
	plot(-i*I_Kir, V_m, '-');
	plot(-i*I_CaL, V_m, '-');
	end;
set(gca,'FontSize',[20]);

text(-0.32,-80,'Kir','FontSize',[20]);
text(-0.20,-50, 'IAs','FontSize',[20]);
text(0.2,-28, 'CaL','FontSize',[20]);

axis([-0.4,0.4,-100,-20]);
ylabel('mV');
xlabel('\mu A/cm^2');
set(gca,'XTick',[-0.4,-0.2,0,0.2,0.4]);
set(gca,'XTickLabel',[0.4,0.2,0,-0.2,-0.4]);

print -deps Ir_vm_Kir_KAs_CaL.eps;
print -djpeg Ir_vm_Kir_KAs_CaL.jpg;

end;
