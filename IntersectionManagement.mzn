% Use this editor as a MiniZinc scratch book
array[1..12] of var 0..1: paths;
%array[1..12] of 0..1: current_path;

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

 