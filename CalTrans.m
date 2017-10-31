function Trans = CalTrans(Index1,Index2,Index3,Index4,NeighbourSet)
%计算四个点练连成的两个向量的相对位置关系
% 返回值大于0，pointOne和pointTwo连成的向量在pointThree和pointFour连成的向量的顺时针方向上

Trans=((NeighbourSet(1,Index2)-NeighbourSet(1,Index1))*(NeighbourSet(2,Index4)-NeighbourSet(2,Index3))-(NeighbourSet(1,Index4)-NeighbourSet(1,Index3))*(NeighbourSet(2,Index2)-NeighbourSet(2,Index1)));

end

