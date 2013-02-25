function refresh_neurondata(handles)

%
% refresh all gui elements after changes of the neurondata data block
%
sim = getappdata(gcbf, 'sim');
c = sim.gui.current_neuron;

%neurondata = simdata.neurondata(c);
%
%set(handles.slider_subthr_osc_freq, 'Value', neurondata.subthr_osc_freq);
%set(handles.slider_subthr_osc_ampl, 'Value', neurondata.subthr_osc_ampl);
%set(handles.synweight, 'Value', neurondata.synweight);
%set(handles.slider_beta_duration, 'Value', neurondata.beta_duration);
%set(handles.pushbutton_beta, 'Value', neurondata.beta_active);
%set(handles.slider_beta_amount, 'Value', neurondata.beta_V_depol);
%set(handles.t_gamma, 'Value', neurondata.t_gamma);
%set(handles.checkbox3, 'Value', neurondata.gamma_active);
%set(handles.gamma_0, 'Value', neurondata.gamma_0);
%set(handles.slider_alpha_duration, 'Value', neurondata.alpha_duration);
%set(handles.slider_alpha_amount, 'Value', neurondata.alpha_amount);
%set(handles.pushbutton_alpha, 'Value', neurondata.alpha_active);

%setappdata(gcbf, 'neurondata',neurondata);

set(handles.edit5,'String',c);

