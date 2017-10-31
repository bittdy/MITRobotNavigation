function [ NewConvexPoints ] = ViewableConvex( ObstacleCircle,GoalPositionX,GoalPositionY,CurrentPositionX,CurrentPositionY,RobotPosition )
%�˺����ÿ����߷����õ���ǰ���µ�͹���㣬����֮��ĳ������������������͹��
%   �����Ϊ�ϰ���Բ��Բ���Լ��뾶���Լ�Ŀ��λ�ú͵�ǰ���л����˵�λ��
%���⣺����Ҫ�ѱ߽���뵽obstacleCell�У��涨obstacleCellΪ���о���1��2��ΪԲ��x��y���꣬3��Ϊ�뾶

%֮���������жϵ��滮���ĵ�����һ���ϰ�������ô��


%��ÿ���ϰ���ȷ����û�н��㣬���б�ֹͣ������������ǰ�е㣬û�еĻ���Ŀ��㷵��
Flag=0;
HaveInterPoint=[1,1,1];
for i=1:length(ObstacleCircle)
    Result=JudgeInter( CurrentPositionX,CurrentPositionY,GoalPositionX,GoalPositionY,ObstacleCircle(i,1),ObstacleCircle(i,2),ObstacleCircle(i,3));
    if Result==1   %˵���н���
        Flag=1;
        HaveInterPoint=[HaveInterPoint;[ObstacleCircle(i,1),ObstacleCircle(i,2),ObstacleCircle(i,3)]];
%         CentroidX=ObstacleCircle(i,1);
%         CentroidY=ObstacleCircle(i,2);
%         Radius=ObstacleCircle(i,3);
%         break;
    end
end
HaveInterPoint(1,:)=[];
Distan=[];
for z=1:size(HaveInterPoint,1)
    Distan=[Distan,(HaveInterPoint(z,1)-CurrentPositionX)^2+(HaveInterPoint(z,2)-CurrentPositionX)^2];
end
if Flag==0  %û�����κ��ϰ����ཻ
    NewConvexPoints=[GoalPositionX,GoalPositionY];
else
    [~,ind]=min(Distan);
    CentroidX=HaveInterPoint(ind,1);
    CentroidY=HaveInterPoint(ind,2);
    Radius=HaveInterPoint(ind,3);
    a=(CurrentPositionY-CentroidY)^2+(CurrentPositionX-CentroidX)^2;
    b=-2*Radius^2*(CurrentPositionX-CentroidX);
    c=Radius^4-(CurrentPositionY-CentroidY)^2*Radius^2;
    if b^2-4*a*c<0
        %���������ϰ��������ڣ�����ͶӰ
        NextGoalPositionQue=[CurrentPositionX,CurrentPositionY]';
        NewConvexPoints= GetFinalGoal( NextGoalPositionQue,ObstacleCircle );
        NewConvexPoints=NewConvexPoints';
    else
        x0=(-b+sqrt(b^2-4*a*c))/(2*a)+CentroidX;
        x1=(-b-sqrt(b^2-4*a*c))/(2*a)+CentroidX;
        y0=(Radius^2-(CurrentPositionX-CentroidX)*(x0-CentroidX))/(CurrentPositionY-CentroidY)+CentroidY;
        y1=(Radius^2-(CurrentPositionX-CentroidX)*(x1-CentroidX))/(CurrentPositionY-CentroidY)+CentroidY;
        %ʹ�е㲻��Բ���Լ�Բ��
        if x0>CentroidX
            x0=x0+3;
        else
            x0=x0-3;
        end
        if x1>CentroidX
            x1=x1+3;
        else
            x1=x1-3;
        end
        if y0>CentroidY
            y0=y0+3;
        else
            y0=y0-3;
        end
        if y1>CentroidY
            y1=y1+3;
        else
            y1=y1-3;
        end
        x=[x0,x1]';
        y=[y0,y1]';
        k=(GoalPositionY-CurrentPositionY)/(GoalPositionX-CurrentPositionX+0.01);
        b=(GoalPositionX*CurrentPositionY-CurrentPositionX*GoalPositionY)/(GoalPositionX-CurrentPositionX+0.01);
        if (k*x(1,:)+b-y(1,:))*(k*CentroidX+b-CentroidY)<=0      %���е���Բ�Ĳ���һ�ߣ������ӻ�
            NewConvexPoints=[x(1,:),y(1,:)];
        else
            NewConvexPoints=[x(2,:),y(2,:)];
        end
    end
end
end