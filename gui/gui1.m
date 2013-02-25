function varargout = gui1(varargin)
% GUI1 M-file for gui1.fig

% Edit the above text to modify the response to help gui1

% Last Modified by GUIDE v2.5 08-Oct-2007 21:33:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui1_OpeningFcn, ...
                   'gui_OutputFcn',  @gui1_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui1 is made visible.
function gui1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui1 (see VARARGIN)

% Choose default command line output for gui1
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

fprintf('got here...\n');
%setappdata(hObject,'xx',xx);
%init_sim;
%which sim
%eval('sim2=sim');
%setappdata(hObject,'sim',sim2);
% use with getappdata(handles.figure1,'sim');
%set(handles.text_mu_4,'String','foo');

% UIWAIT makes gui1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui1_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function input_freq_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_freq_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

if (1==1),
%----------------------------------
disp('loading configuration data...');

N_nn = 3;
neuron_type='neuron_izh';
T_upd = 100;

init_sim;

sim.gui.fnc = '????';
sim.gui.zoom = 1;
sim.gui.pos = 1;
sim.gui.current_neuron = 1;
sim.gui.hold_V_membr = 0;

setappdata(gcbf, 'sim', sim);
setappdata(gcbf, 'input_params', input_params);
setappdata(gcbf, 'input_params', input_params);
setappdata(gcbf, 'input_params_inh', input_params_inh);
setappdata(gcbf, 'nn_mu_params', nn_mu_params);
disp('done loading configuration data...');

end;

% --- Executes on slider movement.
function input_freq_slider_Callback(hObject, eventdata, handles)
% hObject    handle to input_freq_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%----------------------------------
%NYI input_freq = get(hObject,'Value');
%NYI data = getappdata(gcbf, 'inputdata');
%NYI data.input_freq = input_freq;
%NYI setappdata(gcbf, 'inputdata', data);
%----------------------------------



% --- Executes during object creation, after setting all properties.
function input_thr_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_thr_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on slider movement.
function input_thr_slider_Callback(hObject, eventdata, handles)
% hObject    handle to input_thr_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%----------------------------------
%NYI input_thr = get(hObject,'Value');
%NYI data = getappdata(gcbf, 'inputdata');
%NYI data.input_thr = input_thr;
%NYI setappdata(gcbf, 'inputdata', data);
%----------------------------------


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%
% RUN:  Run all neurons *without* saving current neuron
% NOTE: subthr_osc + V_membr are currently duplicated into the neuron-vector
%
%----------------------------------
sim = getappdata(gcbf, 'sim');
nn_mu_params = getappdata(gcbf, 'nn_mu_params');
input_params = getappdata(gcbf, 'input_params');
input_params_inh = getappdata(gcbf, 'input_params_inh');

run_sim;

setappdata(gcbf, 'sim', sim);

plot_results(handles, sim, nn_inputs);
%----------------------------------


% --- Executes during object creation, after setting all properties.
function slider_subthr_osc_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_subthr_osc_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on slider movement.
function slider_subthr_osc_freq_Callback(hObject, eventdata, handles)
% hObject    handle to slider_subthr_osc_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%----------------------------------
%NYI subthr_osc_freq = get(hObject,'Value');
%NYI data = getappdata(gcbf, 'neurondata');
%NYI data.subthr_osc_freq = subthr_osc_freq;
%NYI setappdata(gcbf, 'neurondata', data);
%NYI set(handles.neuron_save, 'BackgroundColor', [0.85,0.4,0.24]);
%----------------------------------


% --- Executes during object creation, after setting all properties.
function slider_subthr_osc_ampl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_subthr_osc_ampl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on slider movement.
function slider_subthr_osc_ampl_Callback(hObject, eventdata, handles)
% hObject    handle to slider_subthr_osc_ampl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%----------------------------------
%NYI subthr_osc_ampl = get(hObject,'Value');
%NYI data = getappdata(gcbf, 'neurondata');
%NYI data.subthr_osc_ampl = subthr_osc_ampl;
%NYI setappdata(gcbf, 'neurondata', data);
%NYI set(handles.neuron_save, 'BackgroundColor', [0.85,0.4,0.24]);
%----------------------------------


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%--------------------------------------------------------
current_snapshot = str2double(get(hObject,'String'))
sim = getappdata(gcbf, 'sim');
if (~(sim.fnc == current_snapshot))
	sim.gui.fnc = current_snapshot;
	setappdata(gcbf, 'sim', sim);
end;

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function slider_zoom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_zoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on slider movement.
function slider_zoom_Callback(hObject, eventdata, handles)
% hObject    handle to slider_zoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%----------------------------------
zoom = get(hObject,'Value');
sim = getappdata(gcbf, 'sim');
sim.gui.zoom = zoom;
setappdata(gcbf, 'sim', sim);
%----------------------------------


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function input_selector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_selector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in input_selector.
function input_selector_Callback(hObject, eventdata, handles)
% hObject    handle to input_selector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns input_selector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from input_selector
disp('selection ');
get(hObject, 'Value')
%----------------------------------
%NYI input_type = get(hObject,'Value');
%NYI data = getappdata(gcbf, 'inputdata');
%NYI data.input_type = input_type;
%NYI setappdata(gcbf, 'inputdata', data);
%----------------------------------



% --- Executes during object creation, after setting all properties.
function slider_input_strength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_input_strength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on slider movement.
function slider_input_strength_Callback(hObject, eventdata, handles)
% hObject    handle to slider_input_strength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%----------------------------------
%NYI input_strength = get(hObject,'Value');
%NYI data = getappdata(gcbf, 'inputdata');
%NYI data.input_strength = input_strength;
%NYI setappdata(gcbf, 'inputdata', data);
%----------------------------------


% --- Executes during object creation, after setting all properties.
function slider_alpha_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_alpha_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on slider movement.
function slider_alpha_duration_Callback(hObject, eventdata, handles)
% hObject    handle to slider_alpha_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%----------------------------------
%NYI alpha_duration = get(hObject,'Value');
%NYI data = getappdata(gcbf, 'neurondata');
%NYI data.alpha_duration = alpha_duration;
%NYI setappdata(gcbf, 'neurondata', data);
set(handles.neuron_save, 'BackgroundColor', [0.85,0.4,0.24]);
%----------------------------------


% --- Executes during object creation, after setting all properties.
function slider_alpha_amount_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_alpha_amount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on slider movement.
function slider_alpha_amount_Callback(hObject, eventdata, handles)
% hObject    handle to slider_alpha_amount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%----------------------------------
%NYI alpha_amount = get(hObject,'Value');
%NYI data = getappdata(gcbf, 'neurondata');
%NYI data.alpha_amount = alpha_amount;
%NYI setappdata(gcbf, 'neurondata', data);
set(handles.neuron_save, 'BackgroundColor', [0.85,0.4,0.24]);
%----------------------------------


% --- Executes during object creation, after setting all properties.
function slider_mu_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_mu_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on slider movement.
function slider_mu_1_Callback(hObject, eventdata, handles)
% hObject    handle to slider_mu_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%----------------------------------
mu1 = get(hObject,'Value');
nn_mu_params = getappdata(gcbf, 'nn_mu_params');
sim = getappdata(gcbf, 'sim');
nn_mu_params(sim.gui.current_neuron,1) = mu1;
setappdata(gcbf, 'nn_mu_params', nn_mu_params);
set(handles.neuron_save, 'BackgroundColor', [0.85,0.4,0.24]);
%----------------------------------


% --- Executes during object creation, after setting all properties.
function slider_mu_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_mu_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on slider movement.
function slider_mu_2_Callback(hObject, eventdata, handles)
% hObject    handle to slider_mu_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%----------------------------------
mu2 = get(hObject,'Value');
nn_mu_params = getappdata(gcbf, 'nn_mu_params');
sim = getappdata(gcbf, 'sim');
nn_mu_params(sim.gui.current_neuron,2) = mu2;
setappdata(gcbf, 'nn_mu_params', nn_mu_params);
set(handles.neuron_save, 'BackgroundColor', [0.85,0.4,0.24]);
%----------------------------------


% --- Executes on button press in pushbutton_beta.
function pushbutton_beta_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pushbutton_beta
%----------------------------------
%NYI data = getappdata(gcbf, 'neurondata');
%NYI data.beta_active = get(hObject,'Value');
%NYI data.beta_active
%NYI setappdata(gcbf, 'neurondata', data);
set(handles.neuron_save, 'BackgroundColor', [0.85,0.4,0.24]);
%----------------------------------



% --- Executes on button press in pushbutton_alpha.
function pushbutton_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pushbutton_alpha

%----------------------------------
%NYI data = getappdata(gcbf, 'neurondata');
%NYI data.alpha_active = get(hObject,'Value');
%NYI setappdata(gcbf, 'neurondata', data);
set(handles.neuron_save, 'BackgroundColor', [0.85,0.4,0.24]);
%----------------------------------


% --- Executes during object creation, after setting all properties.
function slider_position_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on slider movement.
function slider_position_Callback(hObject, eventdata, handles)
% hObject    handle to slider_position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%----------------------------------
pos = get(hObject,'Value');
sim = getappdata(gcbf, 'sim');
%NYI data.pos = pos;
setappdata(gcbf, 'sim', sim);
%----------------------------------


% --------------------------------------------------------------------
function Open_Callback(hObject, eventdata, handles)
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Save_parameters_Callback(hObject, eventdata, handles)
% hObject    handle to Save_parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Close_Callback(hObject, eventdata, handles)
% hObject    handle to Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('Closing....');
delete(handles.figure1);


% --- Executes on button press in plot_alpha.
function plot_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to plot_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plot_alpha

%----------------------------------
sim= getappdata(gcbf, 'sim');
%NYI simdata.plot_alpha = get(hObject,'Value');
setappdata(gcbf, 'sim', sim);
%----------------------------------



% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
%----------------------------------
%NYI data = getappdata(gcbf, 'neurondata');
%NYI data.gamma_active = get(hObject,'Value');
%NYI setappdata(gcbf, 'neurondata', data);
set(handles.neuron_save, 'BackgroundColor', [0.85,0.4,0.24]);
%----------------------------------


% --- Executes during object creation, after setting all properties.
function slides_mu_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slides_mu_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on slider movement.
function slides_mu_3_Callback(hObject, eventdata, handles)
% hObject    handle to slides_mu_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%----------------------------------
mu3 = get(hObject,'Value');
nn_mu_params = getappdata(gcbf, 'nn_mu_params');
sim = getappdata(gcbf, 'sim');
nn_mu_params(sim.gui.current_neuron,3) = mu3;
setappdata(gcbf, 'nn_mu_params', nn_mu_params);
set(handles.neuron_save, 'BackgroundColor', [0.85,0.4,0.24]);
%----------------------------------


% --- Executes during object creation, after setting all properties.
function slides_mu_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slides_mu_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

	%
	% set min and max 
%set(hObject,'Min',-10);
%set(hObject,'Max',10);
%set(hObject,'String','xxx');
%set(handles.text_mu_4,'String','xx');


% --- Executes on slider movement.
function slides_mu_4_Callback(hObject, eventdata, handles)
% hObject    handle to slides_mu_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%----------------------------------
mu4 = get(hObject,'Value');
nn_mu_params = getappdata(gcbf, 'nn_mu_params');
sim = getappdata(gcbf, 'sim');
nn_mu_params(sim.gui.current_neuron,4) = mu4;
setappdata(gcbf, 'nn_mu_params', nn_mu_params);
set(handles.neuron_save, 'BackgroundColor', [0.85,0.4,0.24]);
%----------------------------------


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
%------------------------------------------
current_neuron = str2double(get(hObject,'String'))
sim = getappdata(gcbf, 'sim');
if (~(sim.gui.current_neuron == current_neuron))
    if ((current_neuron >= 1) & (current_neuron <= sim.N_nn))
	sim.gui.current_neuron = current_neuron;
	setappdata(gcbf, 'sim', sim);
	refresh_neurondata(handles);
	set(handles.neuron_save, 'BackgroundColor', [0.702,0.702,0.702]);
    end;
end;
%----------------------------------


% --- Executes on button press in plot_gamma.
function plot_gamma_Callback(hObject, eventdata, handles)
% hObject    handle to plot_gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plot_gamma
%----------------------------------
%NYI data = getappdata(gcbf, 'simdata');
%NYI data.plot_gamma = get(hObject,'Value');
%NYI setappdata(gcbf, 'simdata', data);
%----------------------------------


% --- Executes on button press in V_membr_hold.
function V_membr_hold_Callback(hObject, eventdata, handles)
% hObject    handle to V_membr_hold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of V_membr_hold
%----------------------------------
sim = getappdata(gcbf, 'sim');
sim.gui.hold_V_membr = get(hObject,'Value');
setappdata(gcbf, 'sim', sim);
%----------------------------------


% --- Executes on button press in neuron_prev.
function neuron_prev_Callback(hObject, eventdata, handles)
% hObject    handle to neuron_prev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%----------------------------------
% decrement current neuron number Pushbutton "<"
%
sim = getappdata(gcbf, 'sim');
if (sim.gui.current_neuron > 1)
	sim.gui.current_neuron = sim.gui.current_neuron - 1;
	setappdata(gcbf, 'sim', sim);
	refresh_neurondata(handles);
	set(handles.neuron_save, 'BackgroundColor', [0.702,0.702,0.702]);
end;
%----------------------------------


% --- Executes on button press in neuron_next.
function neuron_next_Callback(hObject, eventdata, handles)
% hObject    handle to neuron_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%----------------------------------
% increment current neuron number Pushbutton ">"
%
sim = getappdata(gcbf, 'sim');
if (sim.gui.current_neuron +1 <= sim.N_nn)
	sim.gui.current_neuron = sim.gui.current_neuron + 1;
	setappdata(gcbf, 'sim', sim);
	refresh_neurondata(handles);
	set(handles.neuron_save, 'BackgroundColor', [0.702,0.702,0.702]);
end;
%----------------------------------


% --- Executes on button press in neuron_save.
function neuron_save_Callback(hObject, eventdata, handles)
% hObject    handle to neuron_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%----------------------------------
sim = getappdata(gcbf, 'sim');
%NYI data.neurondata(data.current_neuron) = getappdata(gcbf, 'neurondata');
%NYI setappdata(gcbf, 'simdata', data);
refresh_neurondata(handles);
set(handles.neuron_save, 'BackgroundColor', [0.702,0.702,0.702]);
%----------------------------------


% --- Executes on button press in run_single.
function run_single_Callback(hObject, eventdata, handles)
% hObject    handle to run_single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%----------------------------------
% RUN-SINGLE: run simulation of current neuron *without* saving
% NOTE: run single does not differ from "RUN" in this version
%
sim = getappdata(gcbf, 'sim');
nn_mu_params = getappdata(gcbf, 'nn_mu_params');
input_params = getappdata(gcbf, 'input_params');
input_params_inh = getappdata(gcbf, 'input_params_inh');

run_sim;

setappdata(gcbf, 'sim', sim);

plot_results(handles, sim, nn_inputs);
%----------------------------------



% --- Executes during object creation, after setting all properties.
function synweight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to synweight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor',[.9 .9 .9]);
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on slider movement.
function synweight_Callback(hObject, eventdata, handles)
% hObject    handle to synweight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%----------------------------------
%NYI data = getappdata(gcbf, 'neurondata');
%NYI data.synweight = get(hObject,'Value');
%NYI setappdata(gcbf, 'neurondata', data);
set(handles.neuron_save, 'BackgroundColor', [0.85,0.4,0.24]);
%----------------------------------


% --- Executes on slider movement.
function slider_gamma_combined_Callback(hObject, eventdata, handles)
% hObject    handle to slider_gamma_combined (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
%----------------------------------
%NYI data = getappdata(gcbf, 'neurondata');
%NYI gamma_modval = get(hObject,'Value');
%NYI disp(gamma_modval);
%NYI [data.gamma_0, data.t_gamma ] = gamma_mod(gamma_modval, data);
%NYI setappdata(gcbf, 'neurondata', data);
%NYI set(handles.slides_mu_4, 'Value', [data.gamma_0]);
%NYI set(handles.slides_mu_3, 'Value', [data.t_gamma]);
%----------------------------------


% --- Executes during object creation, after setting all properties.
function slider_gamma_combined_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_gamma_combined (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton_snapshot.
function pushbutton_snapshot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_snapshot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%----------------------------------
% save a snapshot into file

sim = getappdata(gcbf, 'sim');
nn_mu_params = getappdata(gcbf, 'nn_mu_params');
input_params = getappdata(gcbf, 'input_params');
input_params_inh = getappdata(gcbf, 'input_params_inh');


%NYI fn=sprintf(simdata.filename,simdata.fnc);
%NYI save(fn, 'simdata', 'neurondata', 'inputdata');
%NYI disp('Snapshot saved');
%NYI simdata.fnc = simdata.fnc + 1;
%NYI set(handles.edit2,'String',simdata.fnc);
%NYI setappdata(gcbf, 'simdata', simdata);



% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function load_dop_Callback(hObject, eventdata, handles)
% hObject    handle to load_dop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function close_Callback(hObject, eventdata, handles)
% hObject    handle to Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider18_Callback(hObject, eventdata, handles)
% hObject    handle to slider18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


