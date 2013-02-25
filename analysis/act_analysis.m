%
% 	fireact = act_analysis(sim, off, theend)
% 	calculate fire activity for all neurons from off:theend
%
%	$Revision:$
%
function  fireact = act_analysis(sim, off, theend)

if (off == 0),
	off = 1;
	end;

if (theend == 0),
	theend = sim.T_upd;
	end;


N =sim.N_nn;

firact = zeros(1,N);
ti=1:sim.T_upd-off+1;
for i=1:sim.N_nn,
        sp=find(sim.instrument.allvm(1,i,off:theend) > sim.activity_thr);
	fireact(i)=length(sp);
end;
