%ͨ�������ֲ��������͹��
%��ȡ��Ⱥ�и��������
% CountNum=1;
% for RobotNumber=1:length(Obstacle)
%     if strcmp(get(Obstacle{RobotNumber},'Type'),'line')
%         if get(Obstacle{RobotNumber},'Color')==[1 0 0] % ȷ���Ǽ�Ⱥ�е�������
%             NodeSet.x(CountNum)=get(Obstacle{RobotNumber},'XData');
%             NodeSet.y(CountNum)=get(Obstacle{RobotNumber},'YData');
%             NodeSet.id(CountNum)=CountNum;
%             CountNum=CountNum+1;
%         end
%     end
% end
NodeSet.x=[3,2,5,6,2];
NodeSet.y=[5,3,2,4,1];
NodeSet.id=[1,2,3,4,5];
%�����ڽӾ��󣬴������˽ṹ
% AdjacencyMatrix=[1,1,0,1;1,1,0,0;0,0,1,1;1,0,1,1];
AdjacencyMatrix=[1,1,0,1,1;1,1,0,0,1;0,0,1,0,0;1,0,0,1,0;1,1,0,0,1];
%��������������˽ṹ��ֱ��
Diameter=3;
%�������͹����Ϊ��ʼ͹��
%  MaxConvexHullPoints=convhull(NodeSet.x,NodeSet.y);
%  LastConvexHullPoints=[NodeSet.x(MaxConvexHullPoints);NodeSet.y(MaxConvexHullPoints);NodeSet.id(MaxConvexHullPoints)];
for RobotNumber=1:size(AdjacencyMatrix,1)  %ÿ�������˵���һ��
    NewBeginPoints=[NodeSet.x(RobotNumber),NodeSet.y(RobotNumber),NodeSet.id(RobotNumber)];%�Ա�������Ϊ�������
    NewBeginPoints=NewBeginPoints';
    for n=1:Diameter  %����ֱ����
        for p=1:size(NewBeginPoints,2) %ÿ���㶼Ҫ���е���
            for q=1:size(AdjacencyMatrix,2) %����NewBeginPoints�����ڽӵĵ㣬�Ҹõ㲻��NewBeginPoints��ʱ�����뵽NewBeginPoints��
                if AdjacencyMatrix(NewBeginPoints(3,p),q)==1 && size(find(NewBeginPoints(3,:)==NodeSet.id(q)),2)==0
                    NewBeginPoints=[NewBeginPoints,[NodeSet.x(q),NodeSet.y(q),NodeSet.id(q)]'];
                end
            end
        end
        if size(NewBeginPoints,2)==1 || size(NewBeginPoints,2)==2
            continue;
        end
        ConvexHullPoints=convhull(NewBeginPoints(1,:),NewBeginPoints(2,:));
        FinalConvexHullPoints=NewBeginPoints(:,ConvexHullPoints);
%         %ÿ�������󽻼�
%         FinalConvexHullPoints=Intersection(LastConvexHullPoints(1,:),LastConvexHullPoints(2,:),FinalConvexHullPoints(1,:),FinalConvexHullPoints(2,:));
%         LastConvexHullPoints=FinalConvexHullPoints;
        
%�������˽ṹ
for z=1:size(AdjacencyMatrix,2)
    for w=1:size(AdjacencyMatrix,1)
        if AdjacencyMatrix(z,w)==1
            plot([NodeSet.x(z),NodeSet.x(w)],[NodeSet.y(z),NodeSet.y(w)],':');
        end
    end
end
        text(2,3,'1');
        text(1,2,'2');
        text(3,2,'3');
        text(4,2,'4');
        text(2,1,'5');
        text(4,1,'6');
        %����͹��
        LastX=FinalConvexHullPoints(1,1);
        LastY=FinalConvexHullPoints(2,1);
        for c=2:size(FinalConvexHullPoints,2)
            plot([LastX,FinalConvexHullPoints(1,c)],[LastY,FinalConvexHullPoints(2,c)]);
            LastX=FinalConvexHullPoints(1,c);
            LastY=FinalConvexHullPoints(2,c);
        end
        axis([0 10 0 10]);
        axis square;
%         cla reset;
        
    end
end