function Trans = CalTrans(Index1,Index2,Index3,Index4,NeighbourSet)
%�����ĸ��������ɵ��������������λ�ù�ϵ
% ����ֵ����0��pointOne��pointTwo���ɵ�������pointThree��pointFour���ɵ�������˳ʱ�뷽����

Trans=((NeighbourSet(1,Index2)-NeighbourSet(1,Index1))*(NeighbourSet(2,Index4)-NeighbourSet(2,Index3))-(NeighbourSet(1,Index4)-NeighbourSet(1,Index3))*(NeighbourSet(2,Index2)-NeighbourSet(2,Index1)));

end

