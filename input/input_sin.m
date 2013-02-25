function inp = input_sin(N,f,sw,a,input_params)

inp=zeros(N,1);


t=1;
while (t <= N),
	for j=1:sw,
		inp(t) = a*sin(j*pi/sw);
		t=t+1;
		end;
	
	dt = 0;
% 04/08: make things more regular
%old:	while ((dt < 500/f) | (dt > 2000/f)),
%04/08	while ((dt < 900/f) | (dt > 1100/f)),
	while ((dt < 1000*(1/input_params.sin_dfreq)/f) | (dt > 1000*input_params.sin_dfreq/f)),
		dt = round((1000/f)*(1+randn));
		end;
	t = t+dt;
%	t = max(500/f,t + round((1000/f)*(1+randn)));
	end;

inp = inp(1:N);
	
