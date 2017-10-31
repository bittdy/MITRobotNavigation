%通过迭代分布求出整体凸包
%读取集群中各点的坐标
% CountNum=1;
% for RobotNumber=1:length(Obstacle)
%     if strcmp(get(Obstacle{RobotNumber},'Type'),'line')
%         if get(Obstacle{RobotNumber},'Color')==[1 0 0] % 确定是集群中的智能体
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
%定义邻接矩阵，代表拓扑结构
% AdjacencyMatrix=[1,1,0,1;1,1,0,0;0,0,1,1;1,0,1,1];
AdjacencyMatrix=[1,1,0,1,1;1,1,0,0,1;0,0,1,0,0;1,0,0,1,0;1,1,0,0,1];
%给定或者求出拓扑结构的直径
Diameter=3;
%定义最大凸包作为初始凸包
%  MaxConvexHullPoints=convhull(NodeSet.x,NodeSet.y);
%  LastConvexHullPoints=[NodeSet.x(MaxConvexHullPoints);NodeSet.y(MaxConvexHullPoints);NodeSet.id(MaxConvexHullPoints)];
for RobotNumber=1:size(AdjacencyMatrix,1)  %每个机器人迭代一次
    NewBeginPoints=[NodeSet.x(RobotNumber),NodeSet.y(RobotNumber),NodeSet.id(RobotNumber)];%以本机器人为迭代起点
    NewBeginPoints=NewBeginPoints';
    for n=1:Diameter  %迭代直径次
        for p=1:size(NewBeginPoints,2) %每个点都要进行迭代
            for q=1:size(AdjacencyMatrix,2) %找与NewBeginPoints中相邻接的点，且该点不在NewBeginPoints中时，加入到NewBeginPoints中
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
%         %每步迭代求交集
%         FinalConvexHullPoints=Intersection(LastConvexHullPoints(1,:),LastConvexHullPoints(2,:),FinalConvexHullPoints(1,:),FinalConvexHullPoints(2,:));
%         LastConvexHullPoints=FinalConvexHullPoints;
        
%画出拓扑结构
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
        %画出凸包
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