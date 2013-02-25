%
% generate_events_corr
%
% generate correlated events
%
% 
function [inp,ep] = generate_events_corr(N, M, ts, mu_event, sigma_event, t_arr, corr)

inp = zeros(N, M);

ep=zeros(N,1);

t_start = -2*t_arr*rand;

i=1;
ep(1) = t_start;
while (ep(i) < N),
	ep(i+1) =ep(i) + poisson_rnd(t_arr,1,1);
	i=i+1;
end;

N_ev=i

%rel_corr=t_arr/2;
rel_corr=(1-corr/100)*t_arr;

for i=1:M,
	for j=1:N_ev,
		e= floor(ep(j) +rel_corr*randn);
		e=min(N,e);
		if (e >= 1),
%			inp(e,i) = 1;
			r=floor(max(1,mu_event + sigma_event*randn));
			r=min(N,e+r);
			inp(e:r,i)=1;
		end;
	end;
end;
