function [ RobotPosition ] = DefaultFormationSquare( CentroidX,CentroidY,Theta,Scala )
%����������ĵ㣬�Լ�������ת�Ƕ��µ������ζ����ڸ����������λ������
%���Ϊ�����и��������˵����꣬�Ƿ���Ҫת�����εı�־λ���Լ����Ŀ��Բ���ײ����������Ĭ�����Բ�뾶Ϊ20

%֮��Ҫ�����ж�����������Ĵ��루������ײ��


RobotPosition=[CentroidX+20*Scala*cos((90+Theta)*pi/180),CentroidY+20*Scala*sin((90+Theta)*pi/180);
                         CentroidX+20*Scala*cos((180+Theta)*pi/180),CentroidY+20*Scala*sin((180+Theta)*pi/180);
                         CentroidX+20*Scala*cos((270+Theta)*pi/180),CentroidY+20*Scala*sin((270+Theta)*pi/180);
                         CentroidX+20*Scala*cos(Theta*pi/180),CentroidY+20*Scala*sin(Theta*pi/180)];
% Robot1=plot(RobotPosition(1,1),RobotPosition(1,2),'ro','MarkerSize',10,'LineWidth',8);hold on;
% Robot2=plot(RobotPosition(2,1),RobotPosition(2,2),'ro','MarkerSize',8,'LineWidth',8);hold on;
% Robot3=plot(RobotPosition(3,1),RobotPosition(3,2),'ro','MarkerSize',6,'LineWidth',8);hold on;
% Robot1=plot(RobotPosition(4,1),RobotPosition(4,2),'ro','MarkerSize',4,'LineWidth',8);hold on;
end

