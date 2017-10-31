function [ NewConvexPoints ] = ViewableConvexSingle( ObstacleCircle,GoalPositionX,GoalPositionY,CurrentPositionX,CurrentPositionY )
%此函数用可视线方法得到当前的新的凸包点，用于之后的程序来求最大可行区域的凸包
%   输入的为障碍物圆的圆心以及半径，以及目标位置和当前所有机器人的位置
%问题：首先要把边界加入到obstacleCell中，规定obstacleCell为三列矩阵，1列2列为圆心x，y坐标，3列为半径

%之后加入代码判断当规划出的点在另一个障碍物中怎么办


%与每个障碍物确定有没有交点，若有便停止继续搜索，求当前切点，没有的话将目标点返回
Flag=0;
HaveInterPoint=[1,1,1];
for i=1:length(ObstacleCircle)
    Result=JudgeInter( CurrentPositionX,CurrentPositionY,GoalPositionX,GoalPositionY,ObstacleCircle(i,1),ObstacleCircle(i,2),ObstacleCircle(i,3));
    if Result==1   %说明有交点
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
if Flag==0  %没有与任何障碍物相交
    NewConvexPoints=[GoalPositionX,GoalPositionY];
else
    [~,ind]=min(Distan);
    CentroidX=HaveInterPoint(ind,1);
    CentroidY=HaveInterPoint(ind,2);
    Radius=HaveInterPoint(ind,3);
    a=(CurrentPositionY-CentroidY)^2+(CurrentPositionX-CentroidX)^2;
    b=-2*Radius^2*(CurrentPositionX-CentroidX);
    c=Radius^4-(CurrentPositionY-CentroidY)^2*Radius^2;
    %添加代码，当判别式小于0时说明智能体在障碍物区域内，将其投影出来
    
    if b^2-4*a*c<0
        %智能体在障碍物区域内，向外投影
        NextGoalPositionSingle=[CurrentPositionX,CurrentPositionY]';
        NewConvexPoints= GetFinalGoal( NextGoalPositionSingle,ObstacleCircle );
        NewConvexPoints=NewConvexPoints';
    else
        x0=(-b+sqrt(b^2-4*a*c))/(2*a)+CentroidX;
        x1=(-b-sqrt(b^2-4*a*c))/(2*a)+CentroidX;
        y0=(Radius^2-(CurrentPositionX-CentroidX)*(x0-CentroidX))/(CurrentPositionY-CentroidY)+CentroidY;
        y1=(Radius^2-(CurrentPositionX-CentroidX)*(x1-CentroidX))/(CurrentPositionY-CentroidY)+CentroidY;
        %使切点不在圆上以及圆内
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
        Flag1=JudgeInObstacleSingle(x0,y0,ObstacleCircle);
        Flag2=JudgeInObstacleSingle(x1,y1,ObstacleCircle);
        if Flag1==1 && Flag2==0   %x0,y0在障碍物内而x1,y1不在障碍物区域内
%             NewConvexPoints=[x1,y1];
                NewConvexPoints=[CurrentPositionX,CurrentPositionY];
        elseif Flag1==0 && Flag2==1 %x0,y0不在障碍物内而x1,y1在障碍物区域内
%             NewConvexPoints=[x0,y0];
                NewConvexPoints=[CurrentPositionX,CurrentPositionY];
        elseif Flag1==1 && Flag2==1 %两个点均在障碍物区域内
            NewConvexPoints=[CurrentPositionX,CurrentPositionY];
        else   %两个点均不在障碍物区域内
            k=(GoalPositionY-CurrentPositionY)/(GoalPositionX-CurrentPositionX+0.01);
            b=(GoalPositionX*CurrentPositionY-CurrentPositionX*GoalPositionY)/(GoalPositionX-CurrentPositionX+0.01);
            if (k*x0+b-y0)*(k*CentroidX+b-CentroidY)<=0      %该切点与圆心不在一边，即在劣弧
                NewConvexPoints=[x0,y0];
            else
                NewConvexPoints=[x1,y1];
            end
        end
    end
   
end
end