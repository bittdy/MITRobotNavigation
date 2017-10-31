function [ RobotPosition ] = DefaultFormationSquare( CentroidX,CentroidY,Theta,Scala )
%计算给定中心点，以及伸缩旋转角度下的正方形队形内各个智能体的位置坐标
%输出为队形中各个机器人的坐标，是否需要转换队形的标志位，以及最大的可以不碰撞的伸缩量。默认外接圆半径为20

%之后要加入判断最大收缩量的代码（避免碰撞）


RobotPosition=[CentroidX+20*Scala*cos((90+Theta)*pi/180),CentroidY+20*Scala*sin((90+Theta)*pi/180);
                         CentroidX+20*Scala*cos((180+Theta)*pi/180),CentroidY+20*Scala*sin((180+Theta)*pi/180);
                         CentroidX+20*Scala*cos((270+Theta)*pi/180),CentroidY+20*Scala*sin((270+Theta)*pi/180);
                         CentroidX+20*Scala*cos(Theta*pi/180),CentroidY+20*Scala*sin(Theta*pi/180)];
% Robot1=plot(RobotPosition(1,1),RobotPosition(1,2),'ro','MarkerSize',10,'LineWidth',8);hold on;
% Robot2=plot(RobotPosition(2,1),RobotPosition(2,2),'ro','MarkerSize',8,'LineWidth',8);hold on;
% Robot3=plot(RobotPosition(3,1),RobotPosition(3,2),'ro','MarkerSize',6,'LineWidth',8);hold on;
% Robot1=plot(RobotPosition(4,1),RobotPosition(4,2),'ro','MarkerSize',4,'LineWidth',8);hold on;
end

