function [ ConvexHullPoints ] = CalcuConvHull( NeighbourSet )
%求取每个智能体计算得到的凸包	
	%find the begin point
	k=1;
	for i=1:size(NeighbourSet,2)
		if (NeighbourSet(2,k)>NeighbourSet(2,i)||((NeighbourSet(2,k)==NeighbourSet(2,i)) && (NeighbourSet(1,k)>NeighbourSet(1,i))))	
			k = i;
        end
    end
	temp=NeighbourSet(1,1);
    NeighbourSet(1,1)=NeighbourSet(1,k);
    NeighbourSet(1,k)=temp;
    temp=NeighbourSet(2,1);
    NeighbourSet(2,1)=NeighbourSet(2,k);
    NeighbourSet(2,k)=temp;
	
	%now the begin point is in the [1]
	%sort all the points by the angle, from small to big
	for i=1:size(NeighbourSet,2)
		for j=(i+1):size(NeighbourSet,2)
			if (CalTrans(1,2,1,j,NeighbourSet)<0||(CalTrans(1,i,1,j,NeighbourSet)==0&&CalDis(1,i,NeighbourSet)>CalDis(1,j,NeighbourSet)))
				temp=NeighbourSet(1,i);
				NeighbourSet(1,i)=NeighbourSet(1,j);
                NeighbourSet(1,j)=temp;
                temp=NeighbourSet(2,i);
				NeighbourSet(2,i)=NeighbourSet(2,j);
                NeighbourSet(2,j)=temp;
            end
        end
    end

	%find all the convex points
	top = 3;
    ConvexHullPoints=[1,1];
    PointsBuffer=[1,1];
    for i=1:3
        PointsBuffer(1)=NeighbourSet(1,i);
        PointsBuffer(2)=NeighbourSet(2,i);
        ConvexHullPoints=[ConvexHullPoints(:,:);PointsBuffer];
    end
    ConvexHullPoints(1,:)=[];
	for i=4:size(NeighbourSet,2) %#ok<ALIGN>
		%while (ConvexHullPoints(1,top)-ConvexHullPoints(1,top-1))*(NeighbourSet(2,i)-ConvexHullPoints(2,top-1))-(NeighbourSet(1,i)-ConvexHullPoints(1,top-1))*(ConvexHullPoints(2,top)-ConvexHullPoints(2,top-1))<0 %#ok<ALIGN>
        while  CalTrans(top-1,top,top-1,i,NeighbourSet)<0
			--top;
            ConvexHullPoints(top,:)=[];
        end
        top=top+1;
        PointsBuffer(1)=NeighbourSet(1,i);
        PointsBuffer(2)=NeighbourSet(2,i);
        ConvexHullPoints=[ConvexHullPoints(:,:);PointsBuffer];
    end
    
    ConvexHullPoints=ConvexHullPoints';
end


