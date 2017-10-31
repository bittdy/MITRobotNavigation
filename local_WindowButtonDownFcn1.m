function local_WindowButtonDownFcn1(varargin)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
global xButton;
global yButton;
pt=get(gca,'CurrentPoint');
xButton = pt(1,1);
yButton = pt(1,2);
fprintf('x=%f,y=%f\n',x,y);
end

function GraduateFinal
%һ����ռ�õķ�ʽ�����֣���̬�ϰ����̬�ϰ����Ⱥ�ڶ��ѣ��ֱ��ò�ͬ���Ŵ����Ա����
figure('WindowButtonDownFcn',@local_WindowButtonDownFcn);
%��ʼ������
axis([0 200 0 200]);
axis square;
Rectangle1=rectangle('Position',[130,130,20,20],'Curvature', [0 0], 'FaceColor','b');hold on;
Rectangle2=rectangle('Position',[50,70,30,30],'Curvature', [0 0], 'FaceColor','b');hold on;
Rectangle3=rectangle('Position',[160,0,40,40],'Curvature', [0 0], 'FaceColor','b');hold on;

MoveObstacle1=plot(10,20,'go','MarkerSize',10,'LineWidth',8);hold on;
MoveObstacle2=plot(120,80,'go','MarkerSize',10,'LineWidth',8);hold on;
ObstacleCell=[130,130,150,150,130,50,50,80,80,50,160,160,200,200,160,0,0,200,200,0;130,150,150,130,130,70,110,110,70,70,0,40,40,0,0,0,200,200,0,0];
Robot1=plot(30,180,'ro','MarkerSize',10,'LineWidth',8);hold on;
Robot2=plot(15,165,'ro','MarkerSize',10,'LineWidth',8);hold on;
Robot3=plot(30,150,'ro','MarkerSize',10,'LineWidth',8);hold on;
Robot4=plot(45,165,'ro','MarkerSize',10,'LineWidth',8);hold on;

%���������˵ı߽��Լ�����Ұ��
MoveObstacle1Bound=rectangle('Position',[0,10,20,20],'Curvature',[1,1]);
MoveObstacle2Bound=rectangle('Position',[110,70,20,20],'Curvature',[1,1]);
MoveObstacle1Predict=rectangle('Position',[1,10,20,20],'Curvature',[1,1],'LineStyle',':');
MoveObstacle2Predict=rectangle('Position',[110,71,20,20],'Curvature',[1,1],'LineStyle',':');
%��Բ����Щ�����������������Բ��Ϊ��Ұ
Obstacle={Rectangle1,Rectangle2,Rectangle3,MoveObstacle1,MoveObstacle2,...
    Robot1,Robot2,Robot3,Robot4};%�����ϰ���Ԫ��
ObstacleCircle=[140,140,35;65,85,40;180,20,40];%Բ��Լ�������µ��ϰ���Լ��
ObstacleCircleForRobot=[140,140,25;65,85,30;180,20,30];%������ϰ���Լ���뾶С����һϵ��Բ�����ڵ������˹滮·��
Static1=rectangle('Position',[105,105,70,70],'Curvature',[1,1]);
Static2=rectangle('Position',[25,45,80,80],'Curvature',[1,1]);
Static3=rectangle('Position',[140,-20,80,80],'Curvature',[1,1]);
StaticLittle1=rectangle('Position',[115,115,50,50],'Curvature',[1,1],'LineStyle',':');
StaticLittle2=rectangle('Position',[35,55,60,60],'Curvature',[1,1],'LineStyle',':');
StaticLittle3=rectangle('Position',[150,-10,60,60],'Curvature',[1,1],'LineStyle',':');
Robot={Robot1,Robot2,Robot3,Robot4};
[MatrixEnv,MatrixObstcle]=InitialEnv(Obstacle,20);
GoalPositon=plot(20,20,'*');hold on;
PlanGoalPositon=plot(20,20,'*');hold on;
GoalPositionSingle1=plot(20,20,'*');hold on;
GoalPositionSingle2=plot(20,20,'*');hold on;
GoalPositionSingle3=plot(20,20,'*');hold on;
GoalPositionSingle4=plot(20,20,'*');hold on;
PlanFinalGoalPositon=plot(20,20,'*');hold on;
IterCount=0;BeginX=20;BeginY=60;MoveDX=1;MoveDY=1;
NeedNewNext=0;
NeedNewGoal=1;
GoCount=1;
GoCountSingle=1;
%�滮����
while 1
    %��̬�����˿�ʼ�˶�����ʼ���������õ����������Լ��ϰ������
    IterCount=IterCount+1;
    BeginX=BeginX+MoveDX;
    BeginY=BeginY+MoveDY;
    set(MoveObstacle1,'XData',BeginX);
    set(MoveObstacle1Bound,'Position',[BeginX-10,10,20,20]);
    if get(MoveObstacle1,'XData')> 70 || get(MoveObstacle1,'XData')<10
        MoveDX=-MoveDX;
    end
    set(MoveObstacle2,'YData',BeginY);
    set(MoveObstacle2Bound,'Position',[110,BeginY-10,20,20]);
    if get(MoveObstacle2,'YData')>80 || get(MoveObstacle2,'YData')<20
        MoveDY=-MoveDY;
    end
    
    %�����ϰ���λ�þ���

    %�������Ŀ��λ��
    if NeedNewGoal==1
        
%         [SubPosXFirst,SubPosYFirst]=CreateGoalPos(ObstacleCircle);
        %          [SubPosX,SubPosY]=ginput;
        %��֮��ÿ�ι滮�ģ��������յ�
%         SubPosFirst=[SubPosXFirst,SubPosYFirst]';
        SubPosFirst=[xButton,yButton]';
        SubPosFinal=GetFinalGoal( SubPosFirst,ObstacleCircle );
        SubPosX=SubPosFinal(1,1);
        SubPosY=SubPosFinal(2,1);
        set(GoalPositon,'XData',SubPosX,'YData',SubPosY); %�������겻�ԣ���������ν������������뻭ͼ�õ����������
        NeedNewGoal=0;
       
    end
% [SubPosX,SubPosY]=ginput;
    %�����˵�ǰλ����͹��
   
    %�Ӵ��룬��convex����ʧ����ô�죬�Ա��⹲�����
    %         run('DistriCalcuConvex.m'); %��DistriCalcuConvex;���÷ֲ�ʽ��͹���ű�
    %�����������ڵõ������˼�Ⱥ��͹��ΪFinalConvexHullPoints
    
    %��ȡ��Ⱥ�и��������
    CountNum=1;
    for RobotNumber=1:length(Obstacle)
        if strcmp(get(Obstacle{RobotNumber},'Type'),'line')
            if get(Obstacle{RobotNumber},'Color')==[1 0 0] % ȷ���Ǽ�Ⱥ�е�������
                NodeSet.x(CountNum)=get(Obstacle{RobotNumber},'XData');
                NodeSet.y(CountNum)=get(Obstacle{RobotNumber},'YData');
                NodeSet.id(CountNum)=CountNum;
                CountNum=CountNum+1;
            end
        end
    end
    %�����ڽӾ��󣬴������˽ṹ
    AdjacencyMatrix=[1,1,0,1;1,1,0,0;0,0,1,1;1,0,1,1];
    %��������������˽ṹ��ֱ��
    Diameter=3;
    %�������͹����Ϊ��ʼ͹��
%     MaxConvexHullPoints=convhull(NodeSet.x,NodeSet.y);
%     LastConvexHullPoints=[NodeSet.x(MaxConvexHullPoints);NodeSet.y(MaxConvexHullPoints);NodeSet.id(MaxConvexHullPoints)];
%     for RobotNumber=1:size(AdjacencyMatrix,1)  %ÿ�������˵���һ��
        RobotNumber=1;
        NewBeginPoints=[NodeSet.x(RobotNumber),NodeSet.y(RobotNumber),NodeSet.id(RobotNumber)];%�Ա�������Ϊ�������
        NewBeginPoints=NewBeginPoints';
        for n=1:Diameter  %����ֱ����
            for p=1:size(NewBeginPoints,2) %ÿ���㶼Ҫ���е���
                for q=1:size(AdjacencyMatrix,2) %����NewBeginPoints�����ڽӵĵ㣬�Ҹõ㲻��NewBeginPoints��ʱ�����뵽NewBeginPoints��
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
            LastConvexHullPoints=FinalConvexHullPoints;
            % ÿ�������󽻼�
%             FinalConvexHullPoints=Intersection(LastConvexHullPoints(1,:),LastConvexHullPoints(2,:),FinalConvexHullPoints(1,:),FinalConvexHullPoints(2,:));
%             LastConvexHullPoints=FinalConvexHullPoints;
            
            %         %�������˽ṹ
            %         for z=1:size(AdjacencyMatrix,2)
            %             for w=1:size(AdjacencyMatrix,1)
            %                 if AdjacencyMatrix(z,w)==1
            %                     plot([NodeSet.x(z),NodeSet.x(w)],[NodeSet.y(z),NodeSet.y(w)],':');
            %                 end
            %             end
            %         end
            %                 text(2,3,'1');
            %                 text(1,2,'2');
            %                 text(3,2,'3');
            %                 text(4,2,'4');
            %                 text(2,1,'5');
            %                 text(4,1,'6');
            %                 %����͹��
            %                 LastX=FinalConvexHullPoints(1,1);
            %                 LastY=FinalConvexHullPoints(2,1);
            %                 for c=2:size(FinalConvexHullPoints,2)
            %                     plot([LastX,FinalConvexHullPoints(1,c)],[LastY,FinalConvexHullPoints(2,c)]);
            %                     LastX=FinalConvexHullPoints(1,c);
            %                     LastY=FinalConvexHullPoints(2,c);
            %                 end
            %                 axis([0 10 0 10]);
            %                 axis square;
            %                 cla reset;
            %
        end
%     end
    
    
    if NeedNewNext==0
        %������ͨ����Ұ�������������
        %�ҵ���ǰ�����˱�ӵĶ�������
        
        %Ҫ��һ����RobotPosition
        CurrentPositionX=mean(NodeSet.x);
        CurrentPositionY=mean(NodeSet.y);
        RobotPosition=[NodeSet.x;NodeSet.y];
%         NewConvexPoints= GetRunableConvex( ObstacleCell,SubPosX,SubPosY,CurrentPositionX,CurrentPositionY,RobotPosition );
        NewConvexPoints=ViewableConvex(ObstacleCircle,SubPosX,SubPosY,CurrentPositionX,CurrentPositionY,RobotPosition);
%         NewConvexPoints=[130,120];
        set(PlanFinalGoalPositon,'XData',NewConvexPoints(1,1),'YData',NewConvexPoints(1,2));
       
        LastConvexHullPoints(3,:)=[];
        ConstrainsPoints=[LastConvexHullPoints,NewConvexPoints'];
        RunableConvex=convhull(ConstrainsPoints(1,:),ConstrainsPoints(2,:));
        ConstrainsPoints=ConstrainsPoints(:,RunableConvex');
        %����ת��Ϊ����Լ��������ͨ��������ֱ�߷��̣�
        A=[1,1];b=[];
        for LineNumber=1:length(ConstrainsPoints)-1
            Gradient=(ConstrainsPoints(2,LineNumber+1)-ConstrainsPoints(2,LineNumber))/...
                (ConstrainsPoints(1,LineNumber+1)-ConstrainsPoints(1,LineNumber)+0.01);
            Intercept=(ConstrainsPoints(1,LineNumber+1)*ConstrainsPoints(2,LineNumber)-...
                ConstrainsPoints(1,LineNumber)*ConstrainsPoints(2,LineNumber+1))/...
                (ConstrainsPoints(1,LineNumber+1)-ConstrainsPoints(1,LineNumber)+0.01);
            if(Gradient*CurrentPositionX-CurrentPositionY+Intercept>=0)
                A=[A;[-Gradient,1]];
                b=[b;Intercept];
            else
                A=[A;[Gradient,-1]];
                b=[b;-Intercept];
            end
        end
        A(1,:)=[];
        %��������k
        Gain=2;
        %�滮��һ�ζ�������
        H=[2*(Gain+1),0;0,2*(Gain+1)];
        f=[-2*Gain*CurrentPositionX-2*SubPosX,-2*Gain*CurrentPositionY-2*SubPosY];
        [NextGoal,~]=quadprog(H,f,A,b);
        %����滮�ĵ����ϰ��������ڣ������ͶӰ������Ҫ���ӹ�
        NextGoal=GetFinalGoal( NextGoal,ObstacleCircle );
        %ͶӰ��ϣ��õ����Ĺ滮��
        
        %������A*�㷨�������߹���
%         [RobotPosition,TransFlag,MaxScala]=DefaultFormationSquare...
%             ( NextGoalX,NextGoalY,0,1,4,0.5,4 );
%         for Count=1:length(RobotPosition)
%             RobotX=linspace(get(Robot{Count},'XData'),RobotPosition(1,Count),50); %������get������get�����˶�����������
%             RobotY=linspace(get(Robot{Count},'YData'),RobotPosition(2,Count),50);
%         end
%         NextGoalX=[rand(1)*200,rand(1)*200]';
        Theta=0;Scala=1;%֮����Ҫ��Ҫ���ϴι滮��֮���T��S����������ƽ������
        RobotNewPosition=DefaultFormationSquare( NextGoal(1,1),NextGoal(2,1),Theta,Scala );
        set(PlanGoalPositon,'XData',NextGoal(1,1),'YData',NextGoal(2,1));
        
        ScuFlag= JudgeInObstacle( RobotNewPosition,ObstacleCircleForRobot );
%         CotrFlag=JudgeInObstacle([CurrentPositionX,CurrentPositionY],ObstacleCircle);%����־Ϊ��ȷ�����β������ϰ���������
        while ~ScuFlag           
            Scala=Scala-0.3;
            if Scala<0
                break;
            end
            RobotNewPosition=DefaultFormationSquare( NextGoal(1,1),NextGoal(2,1),Theta,Scala );
            ScuFlag=  JudgeInObstacle( RobotNewPosition,ObstacleCircleForRobot );
        end
        RobotNewPosition=DefaultFormationSquare( NextGoal(1,1),NextGoal(2,1),Theta,Scala );
        set(GoalPositionSingle1,'XData',RobotNewPosition(1,1),'YData',RobotNewPosition(1,2));
        set(GoalPositionSingle2,'XData',RobotNewPosition(2,1),'YData',RobotNewPosition(2,2));
        set(GoalPositionSingle3,'XData',RobotNewPosition(3,1),'YData',RobotNewPosition(3,2));
        set(GoalPositionSingle4,'XData',RobotNewPosition(4,1),'YData',RobotNewPosition(4,2));
        
        %�ѵ�����Щ������ˣ�����ʱ��̬�ϰ������滮����������·������Ҫ�ù̶��������ŵ����for��227�У�����
%         RobotX=zeros(1,50);
%         RobotY=zeros(1,50);
%         for Count=1:length(RobotPosition)
%             RobotX=[RobotX;linspace(get(Robot{Count},'XData'),RobotNewPosition(Count,1),50)]; %������get������get�����˶�����������
%             RobotY=[RobotY;linspace(get(Robot{Count},'YData'),RobotNewPosition(Count,2),50)];
% %             RobotX=[RobotX;linspace(get(Robot{Count},'XData'),rand(1)*200,50)]; %������get������get�����˶�����������
% %             RobotY=[RobotY;linspace(get(Robot{Count},'YData'),rand(1)*200,50)];
%         end
%         RobotX(1,:)=[];
%         RobotY(1,:)=[];
    end
%     if Error<20    %���������˵������λ�ã���ʼǰ����һ����
%         GoCount=GoCount+1;
%     end
%     Error=0;
    MoveObstacle1X=get(MoveObstacle1,'XData');
    MoveObstacle1Y=get(MoveObstacle1,'YData');
    MoveObstacle2X=get(MoveObstacle2,'XData');
    MoveObstacle2Y=get(MoveObstacle2,'YData');
    ObstacleCircleForRobotSingle=[140,140,25;65,85,30;180,20,30;MoveObstacle1X+MoveDX,...
        MoveObstacle1Y,20;MoveObstacle2X,MoveObstacle2Y+MoveDY,20];%������ϰ���Լ���뾶С����һϵ��Բ�����ڵ������˹滮·��
    set(MoveObstacle1Predict,'Position',[MoveObstacle1X+2*MoveDX-20,MoveObstacle1Y-20,40,40]);
    set(MoveObstacle2Predict,'Position',[MoveObstacle2X-20,MoveObstacle2Y+2*MoveDY-20,40,40]);
    RobotX=zeros(1,50);
    RobotY=zeros(1,50);
    for Count=1:length(RobotPosition)
        NextPositionSingle= ViewableConvexSingle( ObstacleCircleForRobotSingle,RobotNewPosition(Count,1),RobotNewPosition(Count,2),RobotPosition(1,Count),RobotPosition(2,Count));
        %���԰������linspace�ĳɴӱ��ι滮�ĳ�ʼλ�õ�Ŀ��λ������50���㣬����ÿ�������ٵ�
        RobotX=[RobotX;linspace(get(Robot{Count},'XData'),NextPositionSingle(1,1),50)]; %������get������get�����˶�����������
        RobotY=[RobotY;linspace(get(Robot{Count},'YData'),NextPositionSingle(1,2),50)];
        %             RobotX=[RobotX;linspace(get(Robot{Count},'XData'),rand(1)*200,50)]; %������get������get�����˶�����������
        %             RobotY=[RobotY;linspace(get(Robot{Count},'YData'),rand(1)*200,50)];
    end
    RobotX(1,:)=[];
    RobotY(1,:)=[];
    
    GoCount=GoCount+1;
    for FinalCount=1:length(RobotPosition)
        %��Ŀ�����Բ��ͶӰ
        NextGoalSinglea=[RobotX(FinalCount,GoCount),RobotY(FinalCount,GoCount)]';
        FinalGoalSinglea = GetFinalGoal( NextGoalSinglea,ObstacleCircleForRobotSingle );
        set(Robot{FinalCount},'XData',FinalGoalSinglea(1,1),'YData',FinalGoalSinglea(2,1));
        
    end
    %��������������
    NeedNewNext=1;
    if GoCount==10  %ͨ��50���㵽���˹滮λ�ã����¹滮��һ��λ��
        NeedNewNext=0;
        GoCount=1;
    end
    %���ﵽ��Χ�ں�ʼ��һ�ι滮����
    if ((CurrentPositionX-SubPosX)^2+(CurrentPositionY-SubPosY)^2<200)%1Ϊ��ֵ
        NeedNewGoal=1;
    end
    pause(0.03);
end
end

