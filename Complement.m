function [ RunableRegion ] = Complement( ploygon1,ploygon2 )
%������󲹺�������һ������Ϊ���󲹶���Σ��ڶ�������Ϊ�󲹶����
%   ���Ϊploygon1�����ploygon2�Ĳ�����

%����Ϊ�����������ʱ��������ȷ��������ȷ��ע���ʱ���붼��͹�����
ploygon1=ploygon1(:,convhull(ploygon1(1,:),ploygon1(2,:)));
ploygon2=ploygon2(:,convhull(ploygon2(1,:),ploygon2(2,:)));
%�ҳ���������εĽ���
[InsectionX,InsectionY]=ployxploy(ploygon1(1,:),ploygon1(2,:),ploygon2(1,:),ploygon2(2,:));
%���ų�ploygon1��ploygon2�еĵ㣬��Ȼ���ڲ����ų���
IN=inploygon(ploygon1(1,:);ploygon1(2,:),ploygon2(1,:);ploygon2(2,:));
ploygon1(:,IN)=[];
%�����е���뵽һ��������
RunableRegion=[InsectionX,InsectionY]';
RunableRegion=[RunableRegion,[ploygon1(1,:);ploygon1(2,:)],[ploygon2(1,:);ploygon2(2,:)]];
%�ų�����ploygon1�еĵ�
IN=inploygon(RunableRegion(1,:),RunableRegion(2,:),ploygon1(1,:);ploygon1(2,:));
RunableRegion(:,~IN)=[];
RunableRegion=RunableRegion(:,convhull(RunableRegion(1,:),RunableRegion(2,:)));
end

