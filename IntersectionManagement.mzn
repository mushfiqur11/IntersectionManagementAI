int: maxQueue = 15;
set of int: AllPaths = 1..12;
set of int: Serial = 1..15;
set of int: Property = 1..2;

array[AllPaths,Property,Serial] of int: WaitingQueue;
array[AllPaths,Property,Serial] of var int: NewWaitingQueue;



%Paths array holds all the 12 paths available in a 6 lane street intersection. The variables will be turned to 0 to represent red light and 1 to represent green light.
array[AllPaths] of var 0..1: paths;

array[AllPaths] of 0..1: oldPaths;

array[AllPaths] of var -2..2: changeCost;
    
%Cost of keeping a red light red
int:WaitingCost = 4;
    
%Cost of making a red light green
int:StartingCost = 4;
    
%Cost of keeping green light green
int:MovingCost = 4;

%All the paths that cannot be simultaneously on
constraint paths[1]*paths[3]=0;
constraint paths[1]*paths[6]=0;
constraint paths[1]*paths[8]=0;
constraint paths[1]*paths[7]=0;
constraint paths[2]*paths[3]=0;
constraint paths[2]*paths[4]=0;
constraint paths[2]*paths[8]=0;
constraint paths[2]*paths[6]=0;
constraint paths[2]*paths[5]=0;
constraint paths[3]*paths[5]=0;
constraint paths[3]*paths[8]=0;
constraint paths[4]*paths[5]=0;
constraint paths[4]*paths[8]=0;
constraint paths[4]*paths[6]=0;
constraint paths[4]*paths[7]=0;
constraint paths[5]*paths[7]=0;
constraint paths[6]*paths[7]=0;
constraint paths[6]*paths[8]=0;

%Waiting time cannot be negative
constraint forall(i in AllPaths,k in Serial)(NewWaitingQueue[i,2,k]>=0);

%Updating the priorities
constraint 
forall(i in AllPaths,k in Serial)(
%RED LIGHT
if paths[i]==0 then
NewWaitingQueue[i,1,k]=WaitingQueue[i,1,k]
%GREEN LIGHT
elseif oldPaths[i]==1 /\ k<=9 then %6 cars exiting queue
  NewWaitingQueue[i,1,k] = WaitingQueue[i,1,k+6]
elseif oldPaths[i]==1 /\ k>9 then %6 new spaces in the queue
  NewWaitingQueue[i,1,k] = 0
elseif oldPaths[i]==0 /\ k<=14 then %1 cars exiting queue
  NewWaitingQueue[i,1,k] = WaitingQueue[i,1,k+1]
elseif oldPaths[i]==0 /\ k>14 then %1 new spaces in the queue
  NewWaitingQueue[i,1,k] = 0
else true
endif
);

%Updating the waiting time
constraint 
forall(i in AllPaths,k in Serial)(
%RED LIGHT
if paths[i]==0 /\ WaitingQueue[i,1,k]>0 then 
NewWaitingQueue[i,2,k]=(WaitingQueue[i,2,k]+WaitingCost)
%GREEN LIGHT
elseif oldPaths[i]==1 /\ k<=9 /\ WaitingQueue[i,1,k+6]>0 then %6 cars exiting queue
  NewWaitingQueue[i,2,k] = WaitingQueue[i,2,k+6]+MovingCost 
elseif oldPaths[i]==1 /\ k<=9 /\ WaitingQueue[i,1,k+6]==0 then
  NewWaitingQueue[i,2,k] = 0
elseif oldPaths[i]==1 /\ k>9 then %6 new spaces in the queue
  NewWaitingQueue[i,2,k] = 0
elseif oldPaths[i]==0 /\ k<=14 /\ WaitingQueue[i,1,k+1]>0 then %1 cars exiting queue
  NewWaitingQueue[i,2,k] = WaitingQueue[i,2,k+1]+StartingCost
elseif oldPaths[i]==0 /\ k<=14 /\ WaitingQueue[i,1,k+1]==0 then
  NewWaitingQueue[i,2,k] = 0
elseif oldPaths[i]==0 /\ k>14 then %1 new spaces in the queue
  NewWaitingQueue[i,2,k] = 0
else true
endif

);

constraint
forall(i in AllPaths,k in Serial)(
if paths[i]==1 /\ oldPaths[i]==1 then changeCost[i]=-2
elseif paths[i]==1 /\ oldPaths[i]==0 then changeCost[i]=-1
elseif paths[i]==0 /\ oldPaths[i]==0 then changeCost[i]=1
elseif paths[i]==0 /\ oldPaths[i]==1 then changeCost[i]=2
else true
endif
);


var int: TotalSum = sum(i in AllPaths, k in Serial)(changeCost[i]*NewWaitingQueue[i,1,k]) + sum(i in AllPaths, k in Serial)(abs(1-paths[i])*NewWaitingQueue[i,1,k]*NewWaitingQueue[i,2,k]);

solve minimize TotalSum;
