% 	myexp.m
%
% auxiliary logistic-class function used for ion channels
%
%	$Revision:$
%
function me = myexp(V_m, g, V_h, V_c)

me = g *exp((V_m-V_h)/V_c);
