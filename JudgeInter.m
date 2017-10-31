function [ Result ] = JudgeInter( Point1X,Point1Y,Point2X,Point2Y,CentroidX,CentroidY,Radius )
%此函数判断一条线段是否与圆相交
%   解交点，然后判断交点是否在两点之间
k=(Point2Y-Point1Y)/(Point2X-Point1X+0.01);
b=(Point2X*Point1Y-Point1X*Point2Y)/(Point2X-Point1X+0.01);
t=k^2+1;
m=2*k*b-2*k*CentroidY-2*CentroidX;
n=CentroidX^2+b^2+CentroidY^2-2*CentroidY*b-Radius^2;
if m^2-4*t*n<0  %没有交点
    Result=0;
else
    x0=(-m+sqrt(m^2-4*t*n))/(2*t);
    y0=k*x0+b;
    x1=(-m-sqrt(m^2-4*t*n))/(2*t);
    y1=k*x1+b;
    x=[x0,x1]';
    y=[y0,y1]';
    Result=0;
    for i=1:length(x)
        if (x(i,:)-Point1X)*(x(i,:)-Point2X)>=0 || (y(i,:)-Point1Y)*(y(i,:)-Point2Y)>=0
            continue;
        end
        Result=1;
    end
end
end

