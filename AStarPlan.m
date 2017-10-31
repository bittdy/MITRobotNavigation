function [ WayPoints ] = AStarPlan( StartPosition,GoalPosition, MapMatrix, ObstacleMatrix)
%This function is A star plan function
%   input the start position, goal position and the matrix of map and the
%   obstacle map, then the function return the points of the planway
%   StartPosition and GoalPositon is linear coordinate

%define the move direction
MoveDirection={'L','R','U','D','LU','LD','RU','RD'};

%put the start point in the open list and initial the cost of start 
OpenLists=[MapMatrix(StartPosition)];CloseLists=[];CostChart=[];
while ~max(ismember(OpenList,)) 
end

end

