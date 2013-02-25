% 	myact.m
%
% auxiliary logistic-class function used for ion channels
%
%	$Revision:$
%
function ml = myact(V_m, g, V_h, V_c)

ml = g ./(exp((V_m-V_h)./V_c) + exp(-(V_m-V_h)./V_c));

