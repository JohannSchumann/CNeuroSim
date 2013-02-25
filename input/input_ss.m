function inp = input_ss(input_params, sim)

N=sim.T_upd + input_params.start;

inp=zeros(N,1);

if (length(input_params.ss) > 0),
	for i = 1:2:length(input_params.ss),
		start=max(1,input_params.ss(i));
		stop=min(N,input_params.ss(i+1));
		inp(start:stop) = input_params.ss_ampl;
		end;
else
	for i = 1:length(input_params.ss_train),
		start=max(1,input_params.ss_train(i));
		stop=min(N,input_params.ss_train(i) + input_params.ss_width);
		inp(start:stop) = input_params.ss_ampl;
		end;

end;
