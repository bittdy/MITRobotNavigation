function local_WindowButtonDownFcn(varargin)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
global xButton;
global yButton;
pt=get(gca,'CurrentPoint');
xButton = pt(1,1);
yButton = pt(1,2);
fprintf('x=%f,y=%f\n',x,y);
end

