function [ FinalConvHull ] = Intersection( X1,Y1,X2,Y2 )
%������������ȡ͹������
%Ϊ��ֹ���벻����ʱ��͹�����У����������ݽ��д���
X1=X1(convhull(X1,Y1));
Y1=Y1(convhull(X1,Y1));
X2=X2(convhull(X2,Y2));
Y2=Y2(convhull(X2,Y2));
%������
[X,Y]=polyxpoly(X1,Y1,X2,Y2); %find the intersections of the two ploygons
FinalConvHull=[X,Y]';
FinalConvHull=[FinalConvHull,[X1;Y1],[X2;Y2]];
IN=inpolygon(FinalConvHull(1,:),FinalConvHull(2,:),X1,Y1);%find the points are not in the ploygon1
FinalConvHull(:,~IN)=[];
IN=inpolygon(FinalConvHull(1,:),FinalConvHull(2,:),X2,Y2);%find the points are not in the ploygon2
FinalConvHull(:,~IN)=[];
FinalConvHull=FinalConvHull(:,convhull(FinalConvHull(1,:),FinalConvHull(2,:)));
end

