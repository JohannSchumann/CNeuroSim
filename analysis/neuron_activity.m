%
% calculate number of neuron spikes, given
% a vector of V_m data
% Spike is V_m > 5mV
%
% Use a window-size of W (=10ms);
%
%	$Revision:$
%
function act = neuron_activity(vm, offset, sim)

[spi,spt,act] = calc_spiketrain(vm, sim);
