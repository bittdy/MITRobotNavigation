function [ NeighbourSet ] = IsConnected(NodeIndex,NodeSet,AdjacencyMatrix)
%�ҵ���Ⱥ��ÿһ������ھ�
NeighbourSet=[1,1];
NodeBuffer=[1,1];
for i=1:size(AdjacencyMatrix(NodeIndex,:),2)
   if AdjacencyMatrix(NodeIndex,i)==1
       NodeBuffer(1)=NodeSet.x(i);
       NodeBuffer(2)=NodeSet.y(i);
       NeighbourSet=[NeighbourSet(:,:);NodeBuffer];       
   end
end
NeighbourSet=NeighbourSet';
NeighbourSet(:,1)=[];

