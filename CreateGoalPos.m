function [ SubPosX,SubPosY ] = CreateGoalPos( ObstacleCircle )
%��������������Ŀ��λ�ã����ɵ�Ŀ��λ�ò����ھ�̬�ϰ�����
    SubPosX=200*rand(1);
    SubPosY=200*rand(1);%�������Ŀ���������
    Flag=1;  %Ŀ��λ�ò����ϰ���������ʱFlagΪ0
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

