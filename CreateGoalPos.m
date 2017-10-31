function [ SubPosX,SubPosY ] = CreateGoalPos( ObstacleCircle )
%本函数用于生成目标位置，生成的目标位置不可在静态障碍物上
    SubPosX=200*rand(1);
    SubPosY=200*rand(1);%随机生成目标队形中心
    Flag=1;  %目标位置不在障碍物区域内时Flag为0
    while Flag
        for i=1:length(ObstacleCircle)
            if (ObstacleCircle(i,1)-SubPosX)^2+(ObstacleCircle(i,2)-SubPosY)^2<ObstacleCircle(i,3)^2
                SubPosX=200*rand(1);
                SubPosY=200*rand(1);
                continue;
            end
        end
        Flag=0;
    end
%     for i=1:length(ObstacleCircle)
%         while (ObstacleCircle(i,1)-SubPosX)^2+(ObstacleCircle(i,2)-SubPosY)^2<ObstacleCircle(i,3)^2
%             SubPosX=200*rand(1);
%             SubPosY=200*rand(1);
%         end
%     end
end

