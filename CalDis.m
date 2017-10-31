function [ Distance ] = CalDis( Index1,Index2,NeighbourSet )
%计算两点间距离
Distance=sqrt((NeighbourSet(1,Index2)-NeighbourSet(1,Index1))^2+(NeighbourSet(2,Index2)-NeighbourSet(2,Index1))^2);
end

