function [ Result ] = JudgeInObstacleSingle( PointX,PointY,ObstacleCircle )
%�ж�һ�����Ƿ����ϰ��ﷶΧ��
%  �Ƿ���1�����Ƿ���0
Result=0;
for i=1:length(ObstacleCircle)
        if (ObstacleCircle(i,1)-PointX)^2+(ObstacleCircle(i,2)-PointY)^2<ObstacleCircle(i,3)^2
            Result=1;
            break;
        end
end

end

