% 	neuron_izh.m:
%	
%	IZH neuron for Euler integration
%
%	integrates and updates state
%
%
%	$Revision:$
%
function state = neuron_izh(t, state)

global I_S;
global Ts;
global par;

ct = floor(t/Ts);

%fprintf('neuron_izh: ct=%d I_S = %f %f V_0=%f\n',...
%	ct, I_S(1,ct), I_S(2,ct), state(1));

if(state(1) > 30),
	state(1) = par(3);
	state(2) = state(2) + par(4);
else
	dv = 0.04*state(1).^2 + 5*state(1) + 140 - state(2) ...
	  - par(5)*I_S(1,ct) - par(6)*I_S(2,ct);

	du = par(1).*(par(2).*state(1) - state(2));

		%
		% integration
		%
	state(1) = state(1) + dv*Ts;
	state(2) = state(2) + du*Ts;
	end;


