%
% 	calculate a metric how synchronous
% 	the firing of the neurons are
%
%	$Revision:$
%
function [cspt] = calc_spike_corr(sim)

%HACK:
W_corr=10;

N =sim.N_nn;

cspt = zeros(N, sim.T_upd);

for nn=1:N,
	spt = find(sim.instrument.spiketrain(1,nn,:) > 0);
size(spt)
	for i=spt,
	%
	% analyze fire event @ time i
	%
	corr=0;
	ncorr=0;
	for j=1:N,
		if (j ~= nn),
			% calculate window
			li= min(1, i-0.5*W_corr);
			ri= max(i+0.5*W_corr, sim.T_upd);
			for k=li:ri,
				if (sp_train(j,k) > 0),
				   if (k==i),
				     corr=corr+2;
				   else
				     corr = corr + 1/(k-i).*2;
				   end;
				   ncorr = ncorr+1;
				   end;
			        end;
			end;
		end;
	sp_train(nn,i) = corr;
	end;
	end;
		
					
%
% now obsolete see calc_spiketrain.m
%
%
%function sp_train = calc_spiketrain(vm, sim)
%	
%sp_train=zeros(1,sim.T_upd);
%thr = sim.activity_thr;
%W = sim.activity_win;
%for i=1:W:sim.T_upd-W,
%	a = find(vm(i:i+W-1)>thr);
%	if (a>0),
%		sp_train(i) = 1;
%		end;
%	end;

