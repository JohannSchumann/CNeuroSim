% 	mylog.m
%
% auxiliary logistic-class function used for ion channels
%
%	$Revision:$
%
function ml = mylog(V_m, g, V_h, V_c)

ml = g ./(1+exp((V_m-V_h)./V_c));
