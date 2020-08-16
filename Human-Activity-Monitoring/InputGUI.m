
function varargout = InputGUI(varargin)
% INPUTGUI MATLAB code for InputGUI.fig
%      INPUTGUI, by itself, creates a new INPUTGUI or raises the existing
%      singleton*.
%
%      H = INPUTGUI returns the handle to a new INPUTGUI or the handle to
%      the existing singleton*.
%
%      INPUTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INPUTGUI.M with the given input arguments.
%
%      INPUTGUI('Property','Value',...) creates a new INPUTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before InputGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to InputGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help InputGUI

% Last Modified by GUIDE v2.5 25-Apr-2019 15:18:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @InputGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @InputGUI_OutputFcn, ...
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
end


% --- Executes just before InputGUI is made visible.
function InputGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to InputGUI (see VARARGIN)

% Choose default command line output for InputGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes InputGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end

% --- Outputs from this function are returned to the command line.
function varargout = InputGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.text5.String = ['Calculating Average Frequency']
[filename,filepath] = uigetfile({'*.*';'*.mp4';'*.mov';}, 'Select Video to Analyze');
fullname = [filepath filename];
prompt = 'Enter FileName to Save Output Video to:';
dlgtitle = 'Output Video Name';
dims = [1 35];
definput = {'mov1'};
outputVid = inputdlg(prompt,dlgtitle,dims,definput);
outputVidFile = [outputVid{1}];
%TODO: if string is empty, then put default string: mov1
%or put in while loop and display that string cannot be empty
%TODO: if user presses cancel, then cancel entire video analysis

workingDir = vidToIm(filepath,fullname);
[~,~,~,freq] = ImSeqAnalysis(filepath,filename,outputVidFile);
handles.text5.String = ['Average Frequency: ' num2str(freq) ' Hz'];
implay([filepath outputVidFile '.avi'])

end
