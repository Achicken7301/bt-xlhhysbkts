function varargout = nhap(varargin)
% NHAP MATLAB code for nhap.fig
%      NHAP, by itself, creates a new NHAP or raises the existing
%      singleton*.
%
%      H = NHAP returns the handle to a new NHAP or the handle to
%      the existing singleton*.
%
%      NHAP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NHAP.M with the given input arguments.
%
%      NHAP('Property','Value',...) creates a new NHAP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nhap_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nhap_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nhap

% Last Modified by GUIDE v2.5 23-Jan-2022 09:16:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nhap_OpeningFcn, ...
                   'gui_OutputFcn',  @nhap_OutputFcn, ...
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


% --- Executes just before nhap is made visible.
function nhap_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nhap (see VARARGIN)

% Choose default command line output for nhap
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nhap wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nhap_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Browse.
function Browse_Callback(hObject, eventdata, handles)
% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.*', 'Pick a MATLAB code file');
    if isequal(filename,0) || isequal(pathname,0)
       disp('User pressed cancel')
    else
       filename = strca(pathname,filename);
       a = imread(filename);
       axes(handles.axes1);
       imshow(a);
       handles.o=a;
       guidata(hObject, handles);
    end

% --- Executes on button press in Add_Noise.
function Add_Noise_Callback(hObject, eventdata, handles)
% hObject    handle to Add_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
J = handles.o;
J = imnoise(J,'salt & pepper', 0.4);
axes(handles.axes2);
imshow(J);
handles.J=J;
guidata(hObject, handles);

% --- Executes on button press in Remove_Noise.
function Remove_Noise_Callback(hObject, eventdata, handles)
% hObject    handle to Remove_Noise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
J=handles.J
p=medfilt3(J, [5,5,3]);
axes(handles.axes3);
imshow(p);