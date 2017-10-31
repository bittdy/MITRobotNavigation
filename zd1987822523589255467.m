function zd1987822523589255467
figure('WindowButtonDownFcn',@local_WindowButtonDownFcn)
 
function local_WindowButtonDownFcn(varargin)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch (get(gcbf,'SelectionType'))
    case 'normal'
        str = '单击鼠标左键';
    case 'extend'
        str = 'Shift+左键，或者同时按左右键';
    case 'alt'
        str = 'Ctrl+左键，或者单击右键';
    case 'open'
        str = '双击鼠标任意键';
    otherwise
        str = 'Impossible!!!!';
end
% helpdlg(str, '提示')
disp(str)