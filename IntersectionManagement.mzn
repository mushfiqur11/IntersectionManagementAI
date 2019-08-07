int: maxQueue;
set of int: AllPaths;
set of int: Serial;
set of int: Property;
array[AllPaths,Serial,Property] of int: WaitingQueue;

%Paths array holds all the 12 paths available in a 6 lane street intersection. The variables will be turned to 0 to represent red light and 1 to represent yellow light.
array[AllPaths] of var 0..1: paths;

%array[1..12] of 0..1: current_path;

%Cost of changing a red light to green
int:ChangingCost = 10;

%Cost of keeping a red light red
int:WaitingCost = 30;

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

solve maximize sum(paths);

 