function [ ClosetPoint ] = FindClosestPointOnObstacle( Obstacle,CenterOfRobots )
%函数用于在一个凸障碍物上寻找距离机器人编队最近的点
%   任意取两个顶点，以机器人编队中心向该边投影，计算中心到投影点与顶点的距离取小者
%   如此遍历该障碍物的所有顶点，便能够找到分割障碍物以及机器人集群的超平面
%   其中，Obstacle应是一个障碍物的顶点坐标的集合，每个顶点坐标应按照列的方式组织
MinDistance=Inf;
for i=length(Obstacle)
    %Obstacle(1,:)顶点横坐标，Obstacle(2,:)顶点纵坐标
    
end


end

