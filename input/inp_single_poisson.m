% inp_single_poisson.m
%
% inp_single_poisson
% from: model6/inp_single_poisson
%
% auxiliary function to generate a single input stream (EPSP only)
%
function I_s = inp_single_poisson(N,ts, I0, tau, l);

I_s = inp_poisson(N, 1, 0, l, 0, ts);

return;


