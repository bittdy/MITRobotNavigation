function [ Result ] = JudgeInObstacleSingle( PointX,PointY,ObstacleCircle )
%判断一个点是否在障碍物范围外
%  是返回1，不是返回0
Result=0;
for i=1:length(ObstacleCircle)
        if (ObstacleCircle(i,1)-PointX)^2+(ObstacleCircle(i,2)-PointY)^2<ObstacleCircle(i,3)^2
            Result=1;
            break;
        end
end

end

