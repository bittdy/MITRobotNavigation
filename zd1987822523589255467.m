function zd1987822523589255467
figure('WindowButtonDownFcn',@local_WindowButtonDownFcn)
 
function local_WindowButtonDownFcn(varargin)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch (get(gcbf,'SelectionType'))
    case 'normal'
        str = '����������';
    case 'extend'
        str = 'Shift+���������ͬʱ�����Ҽ�';
    case 'alt'
        str = 'Ctrl+��������ߵ����Ҽ�';
    case 'open'
        str = '˫����������';
    otherwise
        str = 'Impossible!!!!';
end
% helpdlg(str, '��ʾ')
disp(str)