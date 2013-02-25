% $Id:$
%
% generate a sequence of Poisson-distributed 
% events (single ts pulses)
% N=length of sequence in ts time steps
% M=number of channels
% t_mean = mean inter-arrival time
%
function I_S = inp_poisson(N, M, t_event, sigma_event, t_mean, ts)

I_S = zeros(N,1);

%
% offset to get things going
%
tpp0 = zeros(M,1);
tpp0 = -2*lp*rand(M,1);

t_start = min(tpp0);

%---------------------------------------------------
for i=1:M,
	while (tpp0(i) < 0)
		tpp0(i) =tpp0(i) + poisson_rnd(lp,1,1);
		end;
	end;

off = floor(1.5*lp);


tpp = zeros(Mp,N+off);
tpp(:,1) = tpp0;
ti=zeros(Mp,1)+1;

t=0;
for i=1:N,
	I= 0;
	for j=1:Mp,
		if ((t >= tpp(j,ti(j))) & (ti(j) < (N+off)*ts)),
			p = poisson_rnd(lp,1,1);
			ti(j) = ti(j) + 1;
			tpp(j,ti(j)) = t + p;
		end;
		Ik = 0;
		for k=1:ti(j),
			if (t >= tpp(j,k)),
				if (j==3),
					I0 = 3*input_params.I0_p;
				else
					I0 = input_params.I0_p;
					end;
				Ik = Ik +I0*exp(-(t-tpp(j,k))/input_params.tau_p);
			end;
		end;
		I = I+ Ik;
	end;
		
	t = t+ts;
	I_S(i) = I;
end;
