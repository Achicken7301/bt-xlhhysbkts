function varargout = Khang_Vi(varargin)
% KHANG_VI MATLAB code for Khang_Vi.fig
%      KHANG_VI, by itself, creates a new KHANG_VI or raises the existing
%      singleton*.
%
%      H = KHANG_VI returns the handle to a new KHANG_VI or the handle to
%      the existing singleton*.
%
%      KHANG_VI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KHANG_VI.M with the given input arguments.
%
%      KHANG_VI('Property','Value',...) creates a new KHANG_VI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Khang_Vi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Khang_Vi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Khang_Vi

% Last Modified by GUIDE v2.5 24-Jan-2022 22:42:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Khang_Vi_OpeningFcn, ...
                   'gui_OutputFcn',  @Khang_Vi_OutputFcn, ...
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


% --- Executes just before Khang_Vi is made visible.
function Khang_Vi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Khang_Vi (see VARARGIN)

% Choose default command line output for Khang_Vi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Khang_Vi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Khang_Vi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%Bài 2
% --- Executes on button press in Select_Image.
function Select_Image_Callback(hObject, eventdata, handles)
% hObject    handle to Select_Image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
[filename, pathname] = uigetfile('*.*', 'Pick a MATLAB code file');
if isequal(filename,0) || isequal(pathname,0)%help uigetfile
   disp('User pressed cancel')
else
   filename = [pathname filename];
        im = imread(filename);
%  Check if RGB
   if size(im, 3) == 3
        im = rgb2gray(im);
   end
end
assignin('base', 'Image', im);
axes(handles.axes2); imhist(im); title('Histogram');
axes(handles.axes1); imshow(im); title('Image');


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Apply.
function Apply_Callback(hObject, eventdata, handles)
% hObject    handle to Apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
T1 = get(handles.edit1,'String');
T1 = str2double(T1);
T2 = get(handles.edit2,'String');
T2 = str2double(T2);
im_adjust = imadjust(im, [T1/255 T2/255], [0 1]);
axes(handles.axes3); imshow(im_adjust); title('Image');
axes(handles.axes4);imhist(im_adjust); title('Histogram');


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global slider1 slider2 im;
slider1 = get(hObject,'Value');
disp(['slider1: ' num2str(slider1)]);
try
    im_adjust = imadjust(im, [slider1/255 slider2/255], [0 1]);
    axes(handles.axes3); imshow(im_adjust); title('Image');
    axes(handles.axes4);imhist(im_adjust); title('Histogram');
catch
    disp('IMADJUST: LOW_IN must be less than HIGH_IN.');
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


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global slider1 slider2 im;
slider2 = get(hObject,'Value');
% Print error to the termnial
disp(['slider1: ' num2str(slider2)]);
try
    im_adjust = imadjust(im, [slider1/255 slider2/255], [0 1]);
    axes(handles.axes3); imshow(im_adjust); title('Image');
    axes(handles.axes4);imhist(im_adjust); title('Histogram');
catch
    disp('IMADJUST: LOW_IN must be less than HIGH_IN.');
end


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%Bài 3
% --- Executes on button press in Select_Orginal.
function Select_Orginal_Callback(hObject, eventdata, handles)
% hObject    handle to Select_Orginal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_orginal;
[filename, pathname] = uigetfile('*.*', 'Pick a MATLAB code file');
    if isequal(filename,0) || isequal(pathname,0)%help uigetfile
       disp('User pressed cancel')
    else
       filename = [pathname filename];
       im_orginal = imread(filename);
%        Check if RGB
       if size(im_orginal, 3) == 3
            im_orginal = rgb2gray(im_orginal);
       end
       axes(handles.axes5);
       imshow(im_orginal);
    end

% --- Executes on button press in Blurred.
function Blurred_Callback(hObject, eventdata, handles)
% hObject    handle to Blurred (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_orginal;
global blurred;
blurred = imgaussfilt(im_orginal, 5);
% im_blurred = imshowpair(im_orginal, blurred, 'montage');
axes(handles.axes6);
imshow(blurred);

% --- Executes on button press in Unshape_Mask.
function Unshape_Mask_Callback(hObject, eventdata, handles)
% hObject    handle to Unshape_Mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_orginal;
global blurred;
global unsharp;
unsharp = im_orginal - blurred;
axes(handles.axes7);
imshow(unsharp);

% --- Executes on button press in Higher_Image.
function Higher_Image_Callback(hObject, eventdata, handles)
% hObject    handle to Higher_Image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_orginal;
global blurred;
global unsharp;
global hco;
hco = imadjust(im_orginal, [93/255 132/255], [0 1]);
%imshowpair(im_orginal, hco, 'montage');
axes(handles.axes8);
imshow(hco);

% --- Executes on button press in Final_Image.
function Final_Image_Callback(hObject, eventdata, handles)
% hObject    handle to Final_Image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im_orginal;
global blurred;
global unsharp;
global hco;
global delta_value;
global sharpened;
% sharpened = hco + unsharp + I;
delta_value = hco - im_orginal;
sharpened = delta_value + unsharp + im_orginal;
%imshowpair(im_orginal, sharpened, 'montage');
axes(handles.axes9);
imshow(sharpened);
