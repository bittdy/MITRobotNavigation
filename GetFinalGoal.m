function [ FinalGoal ] = GetFinalGoal( NextGoal,ObstacleCircle )
%此函数用于判断规划出的下一时刻的目标位置点是否在障碍物区域内，若在便投影
%Result=1说明NextGoal不在障碍物区域内
Result=1;
for i=1:length(ObstacleCircle)
    if (NextGoal(1,1)-ObstacleCircle(i,1))^2+(NextGoal(2,1)-ObstacleCircle(i,2))^2<(ObstacleCircle(i,3))^2
        Result=0;
        CentroidX=ObstacleCircle(i,1);
        CentroidY=ObstacleCircle(i,2);
        Radius=ObstacleCircle(i,3);
        %各个障碍物区域并不相交，故必然只在一个障碍物区域内，故不用像找交点一样找到一个后继续找
        break;
    end
end

if Result==1
    FinalGoal=NextGoal;
else
    k=(CentroidY-NextGoal(2,1))/(CentroidX-NextGoal(1,1)+0.01);
    b=(CentroidX*NextGoal(2,1)-NextGoal(1,1)*CentroidY)/(CentroidX-NextGoal(1,1)+0.01);
    A=k^2+1;
    B=2*k*b-2*k*CentroidY-2*CentroidX;
    C=CentroidX^2+CentroidY^2+b^2-2*b*CentroidY-Radius^2;
    x0=(-B+sqrt(B^2-4*A*C))/(2*A);
    x1=(-B-sqrt(B^2-4*A*C))/(2*A);
    y0=k*x0+b;
    y1=k*x1+b;
    if (NextGoal(1,1)-x0)*(NextGoal(1,1)-CentroidX)<0 && (NextGoal(2,1)-y0)*(NextGoal(2,1)-CentroidY)<0
        %计算目标点是否在新的目标点和圆心中间，是则符合要求
        if x0>CentroidX
            x0=x0+3;
        else
            x0=x0-3;
        end
        
        if y0>CentroidY
            y0=y0+3;
        else
            y0=y0-3;
        end
        
        FinalGoal=[x0;y0];
    else
        if x1>CentroidX
            x1=x1+3;
        else
            x1=x1-3;
        end
        if y1>CentroidY
            y1=y1+3;
        else
            y1=y1-3;
        end
        FinalGoal=[x1;y1];
    end
end

