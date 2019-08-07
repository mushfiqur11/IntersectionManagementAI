int: maxQueue;
set of int: AllPaths;
set of int: Serial;
set of int: Property;
array[AllPaths,Property,Serial] of int: WaitingQueue;
array[AllPaths,Property,Serial] of var int: NewWaitingQueue;

%Paths array holds all the 12 paths available in a 6 lane street intersection. The variables will be turned to 0 to represent red light and 1 to represent green light.
array[AllPaths] of var 0..1: paths;

array[AllPaths] of 0..1: oldPaths;

%Cost of keeping a red light red
int:WaitingCost = 20;

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
    elseif oldPaths[i]==1 /\ k<=11 then %4 cars exiting queue
          NewWaitingQueue[i,1,k] = WaitingQueue[i,1,k+4]
    elseif oldPaths[i]==1 /\ k>11 then %4 new spaces in the queue
          NewWaitingQueue[i,1,k] = 0
    elseif oldPaths[i]==0 /\ k<=13 then %2 cars exiting queue
          NewWaitingQueue[i,1,k] = WaitingQueue[i,1,k+2]
    elseif oldPaths[i]==0 /\ k>13 then %2 new spaces in the queue
          NewWaitingQueue[i,1,k] = 0
    else true
    endif
    );

%Updating the waiting time
constraint 
  forall(i in AllPaths,k in Serial)(
    %RED LIGHT
    if paths[i]==0 then 
      NewWaitingQueue[i,2,k]=WaitingQueue[i,2,k]+WaitingCost
    %GREEN LIGHT
    elseif oldPaths[i]==1 /\ k<=11 then %4 cars exiting queue
          NewWaitingQueue[i,2,k] = WaitingQueue[i,2,k+4]+WaitingCost
    elseif oldPaths[i]==1 /\ k>11 then %4 new spaces in the queue
          NewWaitingQueue[i,2,k] = 0
    elseif oldPaths[i]==0 /\ k<=13 then %2 cars exiting queue
          NewWaitingQueue[i,2,k] = WaitingQueue[i,2,k+2]+WaitingCost
    elseif oldPaths[i]==0 /\ k>13 then %2 new spaces in the queue
          NewWaitingQueue[i,2,k] = 0
    else true
    endif

    );


var int: TotalSum = sum(i in AllPaths,j in Property, k in Serial)(abs(paths[i]-1)*NewWaitingQueue[i,j,k]);

solve minimize TotalSum;

output [
"\(TotalSum) \(paths)"++

"\n \(NewWaitingQueue[1,1,Serial])"++"  \(NewWaitingQueue[1,2,Serial])"++
"\n \(NewWaitingQueue[2,1,Serial])"++"  \(NewWaitingQueue[2,2,Serial])"++
"\n \(NewWaitingQueue[3,1,Serial])"++"  \(NewWaitingQueue[3,2,Serial])"++
"\n \(NewWaitingQueue[4,1,Serial])"++"  \(NewWaitingQueue[4,2,Serial])"++
"\n \(NewWaitingQueue[5,1,Serial])"++"  \(NewWaitingQueue[5,2,Serial])"++
"\n \(NewWaitingQueue[6,1,Serial])"++"  \(NewWaitingQueue[6,2,Serial])"++
"\n \(NewWaitingQueue[7,1,Serial])"++"  \(NewWaitingQueue[7,2,Serial])"++
"\n \(NewWaitingQueue[8,1,Serial])"++"  \(NewWaitingQueue[8,2,Serial])"++
"\n \(NewWaitingQueue[9,1,Serial])"++"  \(NewWaitingQueue[9,2,Serial])"++
"\n \(NewWaitingQueue[10,1,Serial])"++"  \(NewWaitingQueue[10,2,Serial])"++
"\n \(NewWaitingQueue[11,1,Serial])"++"  \(NewWaitingQueue[11,2,Serial])"++
"\n \(NewWaitingQueue[12,1,Serial])"++"  \(NewWaitingQueue[12,2,Serial])"
]

% output [
% "\(TotalSum) \n\(paths)"
% ++show(NewWaitingQueue)
% ]