function local_WindowButtonDownFcn(varargin)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
global xButton;
global yButton;
pt=get(gca,'CurrentPoint');
xButton = pt(1,1);
yButton = pt(1,2);
fprintf('x=%f,y=%f\n',x,y);
end

