function [ NewConvexPoints ] = GetRunableConvex( ObstacleCell,GoalPositionX,GoalPositionY,CurrentPositionX,CurrentPositionY,RobotPosition )
%�˺����õ���ǰ��Լ�������Ľ��㣬����֮��ĳ������������������͹��
%   �����Ϊ�ϰ����ĸ������Ԫ�����Լ�Ŀ��λ�ú͵�ǰ���л����˵�λ��
%���⣺����Ҫ���ĸ��߽���뵽obstacleCell��


%�жϵ�ǰ����λ�ö���Ŀ�����ĵ����λ��
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
%������һ��״̬����Լ������
%ȷ����ǰ��ЩԼ�������Ի����˼�Ⱥ�����ã������л�����λ�þ��ڸ�Լ������ͬһ�ࣩ
for ObstacleNumber=1:length(ObstacleCell)-1 %��Ϊ���뱣֤��̬�ϰ��ﲻ�뾲̬�ϰ��ﹲ��
    %�Ƿ�ΪԼ�������ı�־
    Flag=0;
    %����ÿһ����
    if (ObstacleCell(1,ObstacleNumber)~=ObstacleCell(1,ObstacleNumber+1)) &&...
            (ObstacleCell(2,ObstacleNumber)~=ObstacleCell(2,ObstacleNumber+1))
        continue;%��ͬһ���ϰ����Լ���߽�
    elseif ObstacleCell(1,ObstacleNumber)==ObstacleCell(1,ObstacleNumber+1) &&  (...
            strcmp(State,'RD')||strcmp(State,'RU'))%x��ȣ�Ϊ�ݱ�,����������
        for RobotNumber=1:length(RobotPosition) %�ж��Ƿ�ΪԼ���߽磬�������Լ��������
            if RobotPosition(1,RobotNumber)>ObstacleCell(1,ObstacleNumber)
                Flag=1;
                break;
            end
        end
        if Flag==0   %���뵽Լ������
            ContrainSetZong=[ContrainSetZong,[ObstacleCell(1,ObstacleNumber);ObstacleCell(2,ObstacleNumber)]];
            ContrainSetZong=[ContrainSetZong,[ObstacleCell(1,ObstacleNumber+1);ObstacleCell(2,ObstacleNumber+1)]];
        end
        
        
    elseif ObstacleCell(1,ObstacleNumber)==ObstacleCell(1,ObstacleNumber+1) &&  (...
            strcmp(State,'LD')||strcmp(State,'LU'))%x��ȣ�Ϊ�ݱߣ�����������
        for RobotNumber=1:length(RobotPosition) %�ж��Ƿ�ΪԼ���߽磬�������Լ��������
            if RobotPosition(1,RobotNumber)<ObstacleCell(1,ObstacleNumber)
                Flag=1;
                break;
            end
        end
        if Flag==0   %���뵽Լ������
            ContrainSetZong=[ContrainSetZong,[ObstacleCell(1,ObstacleNumber);ObstacleCell(2,ObstacleNumber)]];
            ContrainSetZong=[ContrainSetZong,[ObstacleCell(1,ObstacleNumber+1);ObstacleCell(2,ObstacleNumber+1)]];
        end
        
        
        
    elseif ObstacleCell(2,ObstacleNumber)==ObstacleCell(2,ObstacleNumber+1) &&  (...
            strcmp(State,'LU')||strcmp(State,'RU'))%y��ȣ�Ϊ��ߣ�����������
        for RobotNumber=1:length(RobotPosition) %�ж��Ƿ�ΪԼ���߽磬�������Լ��������
            if RobotPosition(2,RobotNumber)>ObstacleCell(2,ObstacleNumber)
                Flag=1;
                break;
            end
        end
        if Flag==0   %���뵽Լ������
            ContrainSetHeng=[ContrainSetHeng,[ObstacleCell(1,ObstacleNumber);ObstacleCell(2,ObstacleNumber)]];
            ContrainSetHeng=[ContrainSetHeng,[ObstacleCell(1,ObstacleNumber+1);ObstacleCell(2,ObstacleNumber+1)]];
        end
        
        
    elseif ObstacleCell(2,ObstacleNumber)==ObstacleCell(2,ObstacleNumber+1) &&  (...
            strcmp(State,'LD')||strcmp(State,'RD'))%y��ȣ�Ϊ��ߣ�����������
        for RobotNumber=1:length(RobotPosition) %�ж��Ƿ�ΪԼ���߽磬�������Լ��������
            if RobotPosition(2,RobotNumber)<ObstacleCell(2,ObstacleNumber)
                Flag=1;
                break;
            end
        end
        if Flag==0   %���뵽Լ������
            ContrainSetHeng=[ContrainSetHeng,[ObstacleCell(1,ObstacleNumber);ObstacleCell(2,ObstacleNumber)]];
            ContrainSetHeng=[ContrainSetHeng,[ObstacleCell(1,ObstacleNumber+1);ObstacleCell(2,ObstacleNumber+1)]];
        end
        
        
    end
end

ContrainSetZong(:,1)=[];
ContrainSetHeng(:,1)=[];

DistanHeng=[];
DistanZong=[];
%�����������õ�Լ��������ȷ����������ģ��������ȶԵ�ǰ�����˼�Ⱥ�����õ�Լ������
for ContrainNumber=1:length(ContrainSetZong)/2  %���㹹��һ��ֱ�ߣ�֮��Ҫע���ҵ���Сֵ����Ϊԭ�����е�һ��
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

%�ҵ�����Լ�������Ľ���
NewConvexPoints=[ContrainSetZong(1,HengInd*2),ContrainSetHeng(2,ZongInd*2)];

end