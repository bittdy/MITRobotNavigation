function [ Result ] = JudgeInObstacle( RobotPosition,ObstacleCircle )
%判断是否全部智能体均在障碍物范围外
%  是返回1，不是返回0
Result=1;
for i=1:length(ObstacleCircle)
    for j=1:length(RobotPosition)
%         m=(ObstacleCircle(i,1)-RobotPosition(j,1))^2;
%         n=(ObstacleCircle(i,2)-RobotPosition(j,2))^2;
%         c=ObstacleCircle^2;
        if (ObstacleCircle(i,1)-RobotPosition(j,1))^2+(ObstacleCircle(i,2)-RobotPosition(j,2))^2<ObstacleCircle(i,3)^2
            Result=0;
            break;
        end
    end
end

end

