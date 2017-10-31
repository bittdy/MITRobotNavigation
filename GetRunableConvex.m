function [ NewConvexPoints ] = GetRunableConvex( ObstacleCell,GoalPositionX,GoalPositionY,CurrentPositionX,CurrentPositionY,RobotPosition )
%此函数得到当前的约束条件的交点，用于之后的程序来求最大可行区域的凸包
%   输入的为障碍物四个顶点的元胞，以及目标位置和当前所有机器人的位置
%问题：首先要把四个边界加入到obstacleCell中


%判断当前中心位置对于目标中心的相对位置
if CurrentPositionX<=GoalPositionX && CurrentPositionY<GoalPositionY
    State='RU';
elseif CurrentPositionX>GoalPositionX && CurrentPositionY<=GoalPositionY
    State='LU';
elseif CurrentPositionX<=GoalPositionX && CurrentPositionY>GoalPositionY
    State='RD';
elseif CurrentPositionX>GoalPositionX && CurrentPositionY>=GoalPositionY
    State='LD';
else
    State='LD';
end

ContrainSetHeng=[1;1];
ContrainSetZong=[1;1];
%根据下一步状态搜索约束条件
%确定当前哪些约束条件对机器人集群有作用（即所有机器人位置均在该约束条件同一侧）
for ObstacleNumber=1:length(ObstacleCell)-1 %人为输入保证动态障碍物不与静态障碍物共边
    %是否为约束条件的标志
    Flag=0;
    %遍历每一条边
    if (ObstacleCell(1,ObstacleNumber)~=ObstacleCell(1,ObstacleNumber+1)) &&...
            (ObstacleCell(2,ObstacleNumber)~=ObstacleCell(2,ObstacleNumber+1))
        continue;%非同一个障碍物的约束边界
    elseif ObstacleCell(1,ObstacleNumber)==ObstacleCell(1,ObstacleNumber+1) &&  (...
            strcmp(State,'RD')||strcmp(State,'RU'))%x相等，为纵边,且向右搜索
        for RobotNumber=1:length(RobotPosition) %判断是否为约束边界，是则加入约束集合中
            if RobotPosition(1,RobotNumber)>ObstacleCell(1,ObstacleNumber)
                Flag=1;
                break;
            end
        end
        if Flag==0   %加入到约束集中
            ContrainSetZong=[ContrainSetZong,[ObstacleCell(1,ObstacleNumber);ObstacleCell(2,ObstacleNumber)]];
            ContrainSetZong=[ContrainSetZong,[ObstacleCell(1,ObstacleNumber+1);ObstacleCell(2,ObstacleNumber+1)]];
        end
        
        
    elseif ObstacleCell(1,ObstacleNumber)==ObstacleCell(1,ObstacleNumber+1) &&  (...
            strcmp(State,'LD')||strcmp(State,'LU'))%x相等，为纵边，且向左搜索
        for RobotNumber=1:length(RobotPosition) %判断是否为约束边界，是则加入约束集合中
            if RobotPosition(1,RobotNumber)<ObstacleCell(1,ObstacleNumber)
                Flag=1;
                break;
            end
        end
        if Flag==0   %加入到约束集中
            ContrainSetZong=[ContrainSetZong,[ObstacleCell(1,ObstacleNumber);ObstacleCell(2,ObstacleNumber)]];
            ContrainSetZong=[ContrainSetZong,[ObstacleCell(1,ObstacleNumber+1);ObstacleCell(2,ObstacleNumber+1)]];
        end
        
        
        
    elseif ObstacleCell(2,ObstacleNumber)==ObstacleCell(2,ObstacleNumber+1) &&  (...
            strcmp(State,'LU')||strcmp(State,'RU'))%y相等，为横边，且向上搜索
        for RobotNumber=1:length(RobotPosition) %判断是否为约束边界，是则加入约束集合中
            if RobotPosition(2,RobotNumber)>ObstacleCell(2,ObstacleNumber)
                Flag=1;
                break;
            end
        end
        if Flag==0   %加入到约束集中
            ContrainSetHeng=[ContrainSetHeng,[ObstacleCell(1,ObstacleNumber);ObstacleCell(2,ObstacleNumber)]];
            ContrainSetHeng=[ContrainSetHeng,[ObstacleCell(1,ObstacleNumber+1);ObstacleCell(2,ObstacleNumber+1)]];
        end
        
        
    elseif ObstacleCell(2,ObstacleNumber)==ObstacleCell(2,ObstacleNumber+1) &&  (...
            strcmp(State,'LD')||strcmp(State,'RD'))%y相等，为横边，且向下搜索
        for RobotNumber=1:length(RobotPosition) %判断是否为约束边界，是则加入约束集合中
            if RobotPosition(2,RobotNumber)<ObstacleCell(2,ObstacleNumber)
                Flag=1;
                break;
            end
        end
        if Flag==0   %加入到约束集中
            ContrainSetHeng=[ContrainSetHeng,[ObstacleCell(1,ObstacleNumber);ObstacleCell(2,ObstacleNumber)]];
            ContrainSetHeng=[ContrainSetHeng,[ObstacleCell(1,ObstacleNumber+1);ObstacleCell(2,ObstacleNumber+1)]];
        end
        
        
    end
end

ContrainSetZong(:,1)=[];
ContrainSetHeng(:,1)=[];

DistanHeng=[];
DistanZong=[];
%在所有起作用的约束条件下确定距离最近的，即最优先对当前机器人集群起作用的约束条件
for ContrainNumber=1:length(ContrainSetZong)/2  %两点构成一条直线，之后要注意找到最小值索引为原索引中的一半
    switch State
        case {'RU','RD'}
            DistanHeng=[DistanHeng,ContrainSetZong(1,ContrainNumber*2)-CurrentPositionX];
        case {'LU','LD'}
            DistanHeng=[DistanHeng,CurrentPositionX-ContrainSetZong(1,ContrainNumber*2)];
    end
end

for ContrainNumber=1:length(ContrainSetHeng)/2
    switch State
        case {'RU','LU'}
            DistanZong=[DistanZong,ContrainSetHeng(2,ContrainNumber*2)-CurrentPositionY];
        case {'RD','LD'}
            DistanZong=[DistanZong,CurrentPositionY-ContrainSetHeng(2,ContrainNumber*2)];
    end
end

[HengMin,HengInd]=min(DistanHeng);
[ZongMin,ZongInd]=min(DistanZong);

%找到两个约束条件的交点
NewConvexPoints=[ContrainSetZong(1,HengInd*2),ContrainSetHeng(2,ZongInd*2)];

end