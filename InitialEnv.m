function [ MatrixEnv, MatrixObstacle ] = InitialEnv( Obstacle, GridSize )
%�ú�������������ϰ���Ԫ���Լ�դ����������ɻ��������Լ��ϰ������
    %   �ڴ�Ĭ������������[0,200],[0,200]��Χ�ڽ���

    %�����ϰ������ͣ�FΪfriend����Ϊ��Ⱥ�������壬SΪstatic����Ϊ��̬�ϰ��MΪmove����Ϊ��̬�ϰ���
    ObstacleStyle=['F','S','M'];
    MatrixEnv=zeros(GridSize,GridSize);
    MatrixObstacle=zeros(GridSize,GridSize);

    for i=1:length(Obstacle)
        switch get(Obstacle{i},'Type')
            case 'rectangle'
                Position=get(Obstacle{i},'Position');
                %�����߼���������ģ�������������������¿�����ôд������������Ҫ��
                IndexX=floor(Position(1)/(200/GridSize))+1;
                IndexY=floor(Position(2)/(200/GridSize))+1;
                NumberX=Position(3)/(200/GridSize);
                NumberY=Position(4)/(200/GridSize);
                MatrixEnv(IndexX:IndexX+NumberX,IndexY:IndexY+NumberY)=1;    %����Ϊ1֮���ʾ�о�̬�ϰ���
                MatrixObstacle(IndexX:IndexX+NumberX,IndexY:IndexY+NumberY)='S';
            case 'line'
                IndexXMin=floor((get(Obstacle{i},'XData')-10)/(200/GridSize))+1;   %����֮��һ��������ռ�������ܷ�õ���ȷ���������ռ�ö࣬������
                IndexXMax=floor((get(Obstacle{i},'XData')+10)/(200/GridSize))+1;
                IndexYMin=floor((get(Obstacle{i},'YData')-10)/(200/GridSize))+1;
                IndexYMax=floor((get(Obstacle{i},'YData')+10)/(200/GridSize))+1;
%                 MatrixEnv(IndexXMin:IndexXMax,IndexYMin:IndexYMax)=1;    %����Ϊ2֮���ʾ�ж�̬�ϰ���
                if get(Obstacle{i},'Color')==[0 1 0]  %��̬�ϰ���Ϊ��ɫ
                    MatrixEnv(IndexXMin:IndexXMax,IndexYMin:IndexYMax)=2;    %����Ϊ2֮���ʾ�ж�̬�ϰ���
                    MatrixObstacle(IndexXMin:IndexXMax,IndexYMin:IndexYMax)='M';
                elseif get(Obstacle{i},'Color')==[1 0 0]   %��Ⱥ������Ϊ��ɫ
                    MatrixEnv(IndexXMin:IndexXMax,IndexYMin:IndexYMax)=3;    %����Ϊ3֮���ʾ���ϰ���
                    MatrixObstacle(IndexXMin:IndexXMax,IndexYMin:IndexYMax)='F';
                end
        end
    end
end

