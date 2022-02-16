function varargout = Section3(varargin)
% SECTION3 MATLAB code for Section3.fig
%      SECTION3, by itself, creates a new SECTION3 or raises the existing
%      singleton*.
%
%      H = SECTION3 returns the handle to a new SECTION3 or the handle to
%      the existing singleton*.
%
%      SECTION3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SECTION3.M with the given input arguments.
%
%      SECTION3('Property','Value',...) creates a new SECTION3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Section3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Section3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Section3

% Last Modified by GUIDE v2.5 15-Feb-2022 15:15:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Section3_OpeningFcn, ...
                   'gui_OutputFcn',  @Section3_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Section3 is made visible.
function Section3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Section3 (see VARARGIN)

% Choose default command line output for Section3
handles.output = hObject;
set(handles.axes1,'XColor', 'none','YColor','none');
set(handles.axes2,'XColor', 'none','YColor','none');
set(handles.axes3,'XColor', 'none','YColor','none');
set(handles.slider1,"visible","off")
set(handles.slider2,"visible","off")
%Add path to get function in path
addpath(genpath('Logic function'));
addpath(genpath('UI function'));
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Section3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Section3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
    global  I option BW;
    value=get(handles.listbox1,"Value");
    listbox=get(handles.listbox1,"string");
    option=(listbox{value});
                assignin("base","option",listbox)

    switch(option)
        case "One Level"
            set(handles.slider1,"visible","on");
        case "Multi Level"
            set(handles.slider1,"visible","on");
            set(handles.slider2,"visible","on");
        case "Auto thresholding "
            set(handles.slider1,"visible","off");
            set(handles.slider2,"visible","off");
            BW=Thresh_holding(I,option);
            axes(handles.axes3)
            imshow(BW)
    end
   

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
    global I count h slider_value1 option BW;
    slider_value1=RoundSliderValue(get(handles.slider1,"value"))
    set(handles.slider1,"value",slider_value1);
    x_data=slider_value1*ones(1,length(count));
    if(option=="One Level")
        BW=Thresh_holding(I,option,slider_value1);
        assignin("base","BW",BW);
        axes(handles.axes3)
        imshow(BW)
    end
    if isempty(h)
        axes(handles.axes2);
        hold on
        %Generate x_data to plot
        h=plot(x_data,count,"LineWidth",2);
    else
        set(h,"XData",x_data);
    end
% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear global
cla;
global I count;
try
    [file_X, folder] = uigetfile("*");
    path = [folder, file_X];
    I = imread(path);
    if size(I, 3) == 3
        I = rgb2gray(I);
    end
    %%Show Origianl Image
    axes(handles.axes1);
    imshow(I);
    title("Original Image");
    %%Show Histogram 
    axes(handles.axes2);
    [count brilocalation]=imhist(I);
    imhist(I);
    title("Histogram");
catch
    s = sprintf('Image not found! Please add an image .dcm, .png, .jpg');
questdlg(s,...
    'Error',...
    'OK','OK');
end



% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
   global I count k slider_value1 slider_value2 option BW;
    slider_value2=RoundSliderValue(get(handles.slider2,"value"));
    set(handles.slider2,"value",slider_value2);
    x_data=slider_value2*ones(1,length(count));
    BW=Thresh_holding(I,option,slider_value1,slider_value2);
    axes(handles.axes3)
    imshow(BW)
    if isempty(k)
        axes(handles.axes2);
        hold on
        %Generate x_data to plot
        k=plot(x_data,count,"LineWidth",2);
    else
        set(k,"XData",x_data);
    end
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global BW;
Saveimage(BW);

