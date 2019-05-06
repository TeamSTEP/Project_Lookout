///scr_grid_place_meeting(x,y,grid_id,grid_val)
//this script will check to see if there are any collisions between the given
//coordinates and the value of the grid.
//returns bool
var xx, yy, grid, grid_val, cellsize;
xx = argument0;
yy = argument1;
grid = argument2;
grid_val = argument3;
cellsize = room_width/ds_grid_width(grid);

if ((ds_grid_get(grid, xx, yy) != grid_val) == grid_val){
    return true;
}
else{return false;}

