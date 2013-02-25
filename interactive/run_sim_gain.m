%
% run gain simulations
%  * nested for-loop over input magnitude
%
%	$Revision:$
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%exc_Mp = [200,300,400,500,900];
%inh_Mn = [20, 40,60, 100, 300, 500];


N_gain_inp =length(exc_Mp);

fprintf('starting gain experiment with %d neuron types and %d inputs\n',...
	sim.N_nn, N_gain_inp);



for inp_idx =1:N_gain_inp,
	input_params.g0 = -2;
	input_params_inh.g0 = -2;
	input_params.Mp = exc_Mp(inp_idx);
	input_params_inh.Mn = inh_Mn(inp_idx);

	fprintf('\nRunning neuron group with Mp=%d Mn=%d:\n',...
		exc_Mp(inp_idx), inh_Mn(inp_idx));
		

	run_sr4;

        m_inp = mean(nn_inputs(1,:)+nn_inputs(2,:),2);
        inp_mag(inp_idx,1:sim.N_nn) = m_inp;
        inp_mag_exc(inp_idx,1:sim.N_nn) = mean(nn_inputs(1,:));
        inp_mag_inh(inp_idx,1:sim.N_nn) = mean(nn_inputs(2,:));

	for i = 1:sim.N_nn,
% 	   m_Cai = mean(sim.instrument.I_Channels(i).Cai(max(1,end-100):end));

	off=1;
	[spi, spt, act] = calc_spiketrain(reshape(sim.instrument.allvm(1,i,off:end),1,sim.T_upd-off+1), sim);

	out_act(inp_idx,i) = act;
	iisi = [spi sim.T_upd] - [0 spi];
	m_isi = mean(iisi(2:end-1));
	s_isi = std(iisi(2:end-1));

        if (~isnan(m_isi) && ((m_isi > 0.0001) || (m_isi ~= -99))),
                out_freq(inp_idx,i) = 1000/m_isi;
        else
                out_freq(inp_idx,i) = 0;
        end;

	
	out_early(inp_idx,i) = 0;
        if (~isempty(spi)),
          if (spi(end) < 0.8*sim.T_upd),
		out_early(inp_idx,i) = 1;
                fprintf('stopped too early\n\n');
                end;
        end;

        mm = mean(iisi(max(1,length(iisi)-10):end));
        if (mm==0),
                out_freq_ss(inp_idx,i) = 0;
        else
                out_freq_ss(inp_idx,i) = 1000/mm;
        end;

	out_Cai(inp_idx,i) = mean(sim.instrument.I_Channels(i).Cai);
	inp_vm(inp_idx,i) = ...
          mean(reshape(sim.instrument.allvm(1,1,1:sim.T_upd),1,sim.T_upd));
	inp_mean(inp_idx,i) = m_inp;
	
	end;

end;


