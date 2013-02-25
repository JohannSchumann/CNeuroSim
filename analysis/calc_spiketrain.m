% 	calculate spiketrain and activity
%
% 	Use a window-size of W (=10ms);
%
%	$Revision:$
%
function [spi, spt, act ]  = calc_spiketrain(vm, sim)

[th, thi] = find(vm > sim.activity_thr);
act=0;
spi=[];
spt=zeros(1,sim.T_upd);

last = -99;
for i=1:length(thi),
	curr =thi(i);
	if (curr - last > sim.activity_win),
%		spt(i) = 1;
		spt(thi(i)) = 1;
		spi = [spi curr];
		act =act + 1;
		end;
	last = curr;
	end;

