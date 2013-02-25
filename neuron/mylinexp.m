% 	mylinexp.m
%
% auxiliary logistic-class function used for ion channels
% Note: to avoid 0/0 division, use a small (0.01) offset in that case
%
%	$Revision:$
%
function ml = mylinexp(V_m, g, V_h, V_c)

if (V_m == V_h),
	V_m = V_m -0.01;
	end;
ml = g *(V_m - V_h)/(1-exp((V_m-V_h)/V_c));
