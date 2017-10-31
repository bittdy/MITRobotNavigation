function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 28-Mar-2017 21:53:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%定义邻接矩阵以及点集
NodeSet.x=[5,10,15,20,5,10,15,20];
NodeSet.y=[160,160,160,160,180,180,180,180];
AdjacencyMatrix=[0,1,1,0,1,0,1,0;
                 0,1,1,0,1,0,1,0;
                 0,1,1,0,1,0,1,0;
                 1,0,1,1,1,0,1,0;
                 0,1,1,0,1,0,1,0;
                 0,1,1,0,1,0,1,0;
                 0,1,1,0,1,0,1,0;
                 0,1,1,0,1,0,1,0];

dt1=0.9;
dt2=0.9;
%两个动态障碍物
x0=10;
y0=80;
x1=150;
y1=60;
%用于画圆的参数
t=0:2*pi/100:2*pi;
r=5;
r1=2;
while 1
    %机器人集群以及动态障碍物
    x0=x0+dt1;
    y1=y1+dt2;
    if x0>100||x0<10
        dt1=-dt1;
    end
    if y1>180||y1<60
        dt2=-dt2;
    end
    %静态障碍物
    rectangle('Position',[136,138,20,20],'Curvature', [0 0], 'FaceColor','g');hold on;
    rectangle('Position',[50,70,30,40],'Curvature', [0 0], 'FaceColor','g');hold on;
    rectangle('Position',[160,0,40,40],'Curvature', [0 0], 'FaceColor','g');hold on;
    Circle1X=x0+r*cos(t);
    Circle1Y=y0+r*sin(t);
    Circle2X=x1+r*cos(t);
    Circle2Y=y1+r*sin(t);
 
    h=plot(Circle1X,Circle1Y,Circle2X,Circle2Y);hold on;
    for k=1:size(NodeSet.x,2)
        NodeSet.x(k)=NodeSet.x(k)+dt1;
        NodeSet.y(k)=NodeSet.y(k)+dt1;
        CircleX=NodeSet.x(k)+r1*cos(t);
        CircleY=NodeSet.y(k)+r1*sin(t);
        plot(CircleX,CircleY);hold on;
    end
    pause(0.01);
    
%     pause(0.01);
  
    axis([0 200 0 200]);
    axis square;
    cla reset;
end
