function [ RunableRegion ] = Complement( ploygon1,ploygon2 )
%多边形求补函数，第一个输入为被求补多边形，第二个输入为求补多边形
%   输出为ploygon1相对于ploygon2的补集点

%首先为两个多边形逆时针排序以确保交点正确，注意此时输入都是凸多边形
ploygon1=ploygon1(:,convhull(ploygon1(1,:),ploygon1(2,:)));
ploygon2=ploygon2(:,convhull(ploygon2(1,:),ploygon2(2,:)));
%找出两个多边形的交点
[InsectionX,InsectionY]=ployxploy(ploygon1(1,:),ploygon1(2,:),ploygon2(1,:),ploygon2(2,:));
%先排除ploygon1在ploygon2中的点，不然后期不好排除掉
IN=inploygon(ploygon1(1,:);ploygon1(2,:),ploygon2(1,:);ploygon2(2,:));
ploygon1(:,IN)=[];
%将所有点加入到一个集合中
RunableRegion=[InsectionX,InsectionY]';
RunableRegion=[RunableRegion,[ploygon1(1,:);ploygon1(2,:)],[ploygon2(1,:);ploygon2(2,:)]];
%排除不在ploygon1中的点
IN=inploygon(RunableRegion(1,:),RunableRegion(2,:),ploygon1(1,:);ploygon1(2,:));
RunableRegion(:,~IN)=[];
RunableRegion=RunableRegion(:,convhull(RunableRegion(1,:),RunableRegion(2,:)));
end

