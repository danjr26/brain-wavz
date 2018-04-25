function varargout = MorseCodeTool(varargin)
% MORSECODETOOL MATLAB code for MorseCodeTool.fig
%      MORSECODETOOL, by itself, creates a new MORSECODETOOL or raises the existing
%      singleton*.
%
%      H = MORSECODETOOL returns the handle to a new MORSECODETOOL or the handle to
%      the existing singleton*.
%
%      MORSECODETOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MORSECODETOOL.M with the given input arguments.
%
%      MORSECODETOOL('Property','Value',...) creates a new MORSECODETOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MorseCodeTool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MorseCodeTool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MorseCodeTool

% Last Modified by GUIDE v2.5 24-Apr-2018 22:34:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MorseCodeTool_OpeningFcn, ...
                   'gui_OutputFcn',  @MorseCodeTool_OutputFcn, ...
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


% --- Executes just before MorseCodeTool is made visible.
function MorseCodeTool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MorseCodeTool (see VARARGIN)

% Choose default command line output for MorseCodeTool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MorseCodeTool wait for user response (see UIRESUME)
% uiwait(handles.figure1);

SetupStreamPlot(handles);

% --- Outputs from this function are returned to the command line.
function varargout = MorseCodeTool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
	varargout{1} = handles.output;


% --- Executes on button press in StartButton.
function StartButton_Callback(hObject, eventdata, handles)
% hObject    handle to StartButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

start(handles.figure1.UserData.updater);

	
% --- Executes on button press in StopButton.
function StopButton_Callback(hObject, eventdata, handles)
% hObject    handle to StopButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

stop(handles.figure1.UserData.updater);


% --- Executes on button press in resetButton.
function resetButton_Callback(hObject, eventdata, handles)
% hObject    handle to resetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mText.String = ' ';
handles.figure1.UserData.code = ' ';









