% inp_poisson.m
%
% generate a sequence of Poisson-distributed EPSPs and IPSPs
% N=length of sequence in ts ms
% Mp = # of Excit. neurons
% Mn = # of inhib neurons
% lp = mean spike interval for excit. neurons
% lp = mean spike interval for inhib. neurons
% input_params used to access I0_*, tau_*
%
function I_S = inp_poisson(input_params, N, Mp, Mn, lp, ln, ts)

%
%I0_p = 0.1;  	%nA
%tau_p = 2.5;	% ms;
%I0_n = -0.033;  	%nA
%tau_n = 3;	% ms;


I_S = zeros(N,1);

%
% offset to get things going
%

tpp0 = zeros(Mp,1);
tpn0 = zeros(Mn,1);

tpp0 = -2*lp*rand(Mp,1);
tpn0 = -2*ln*rand(Mn,1);

t_start = min([min(tpp0),min(tpn0)]);

%---------------------------------------------------
for i=1:Mp,
	while (tpp0(i) < 0)
		tpp0(i) =tpp0(i) + poisson_rnd(lp,1,1);
		end;
	end;

off = floor(1.5*lp);


tpp = zeros(Mp,N+off);
tpp(:,1) = tpp0;
ti=zeros(Mp,1)+1;

t=0;
%for i=1:N+off,
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
%				if (mod(j,5)==0),
% was j==1
				if (j==3),
					I0 = 3*input_params.I0_p;
				else
					I0 = input_params.I0_p;
					end;
%%				Ik = Ik +I0*(t-tpp(j,k))*exp(-(t-tpp(j,k))/input_params.tau_p);
				Ik = Ik +I0*exp(-(t-tpp(j,k))/input_params.tau_p);
			end;
		end;
		I = I+ Ik;
	end;
		
	t = t+ts;
%	if (i > off),
%		I_S(i-off) = I;
%	end;
	I_S(i) = I;
end;

%---------------------------------------------------
for i=1:Mn,
	while (tpn0(i) < 0)
		tpn0(i) =tpn0(i) + poisson_rnd(ln,1,1);
		end;
	end;

off = floor(1.5*ln);


tpn = zeros(Mn,N+off);
tpn(:,1) = tpn0;
ti=zeros(Mn,1)+1;

t=0;
%for i=1:N+off,
for i=1:N,
	I= 0;
	for j=1:Mn,
		if ((t >= tpn(j,ti(j))) & (ti(j) < (N+off)*ts)),
			p = poisson_rnd(ln,1,1);
			ti(j) = ti(j) + 1;
			tpn(j,ti(j)) = t + p;
		end;
		Ik = 0;
		for k=1:ti(j),
			if (t >= tpn(j,k)),
				Ik = Ik +input_params.I0_n*(t-tpn(j,k))*exp(-(t-tpn(j,k))/input_params.tau_n);
%%				Ik = Ik +input_params.I0_n*exp(-(t-tpn(j,k))/input_params.tau_n);
			end;
		end;
		I = I+ Ik;
	end;
		
	t = t+ts;
	I_S(i) = I_S(i) + I;
end;
