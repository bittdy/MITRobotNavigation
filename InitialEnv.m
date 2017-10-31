function [ MatrixEnv, MatrixObstacle ] = InitialEnv( Obstacle, GridSize )
%该函数根据输入的障碍物元胞以及栅格个数，生成环境矩阵以及障碍物矩阵
    %   在此默认整个仿真在[0,200],[0,200]范围内进行

    %定义障碍物类型，F为friend，即为集群内智能体，S为static，即为静态障碍物，M为move，即为动态障碍物
    ObstacleStyle=['F','S','M'];
    MatrixEnv=zeros(GridSize,GridSize);
    MatrixObstacle=zeros(GridSize,GridSize);

    for i=1:length(Obstacle)
        switch get(Obstacle{i},'Type')
            case 'rectangle'
                Position=get(Obstacle{i},'Position');
                %这里逻辑是有问题的，但是在能整除的情况下可以这么写，如果坐标变了要改
                IndexX=floor(Position(1)/(200/GridSize))+1;
                IndexY=floor(Position(2)/(200/GridSize))+1;
                NumberX=Position(3)/(200/GridSize);
                NumberY=Position(4)/(200/GridSize);
                MatrixEnv(IndexX:IndexX+NumberX,IndexY:IndexY+NumberY)=1;    %定义为1之后表示有静态障碍物
                MatrixObstacle(IndexX:IndexX+NumberX,IndexY:IndexY+NumberY)='S';
            case 'line'
                IndexXMin=floor((get(Obstacle{i},'XData')-10)/(200/GridSize))+1;   %测试之后一个智能体占三个格能否得到正确结果，不怕占得多，不能少
                IndexXMax=floor((get(Obstacle{i},'XData')+10)/(200/GridSize))+1;
                IndexYMin=floor((get(Obstacle{i},'YData')-10)/(200/GridSize))+1;
                IndexYMax=floor((get(Obstacle{i},'YData')+10)/(200/GridSize))+1;
%                 MatrixEnv(IndexXMin:IndexXMax,IndexYMin:IndexYMax)=1;    %定义为2之后表示有动态障碍物
                if get(Obstacle{i},'Color')==[0 1 0]  %动态障碍物为绿色
                    MatrixEnv(IndexXMin:IndexXMax,IndexYMin:IndexYMax)=2;    %定义为2之后表示有动态障碍物
                    MatrixObstacle(IndexXMin:IndexXMax,IndexYMin:IndexYMax)='M';
                elseif get(Obstacle{i},'Color')==[1 0 0]   %集群内其他为红色
                    MatrixEnv(IndexXMin:IndexXMax,IndexYMin:IndexYMax)=3;    %定义为3之后表示有障碍物
                    MatrixObstacle(IndexXMin:IndexXMax,IndexYMin:IndexYMax)='F';
                end
        end
    end
end

