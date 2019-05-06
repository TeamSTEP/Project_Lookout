///scr_random_move(moving_range(cells), speed)
var move_dist, spd, minx, miny, maxx, maxy;
move_dist = argument0;
spd = argument1;
minx = x - (move_dist div 2);
miny = y - (move_dist div 2);
maxx = x + (move_dist div 2);
maxy = y + (move_dist div 2);

randomize();
//Get the random value for the char to move
var xx, yy;
xx = irandom_range(minx, maxx);
yy = irandom_range(miny, maxy);

//set the value to stay within the room
xx = clamp(xx, 0, room_width);
yy = clamp(yy, 0, room_height);

while (mp_grid_get_cell(global.mp_grid,x div 66,y div 66) == -1){
    //re-roll random coords if it is in collision
    xx = irandom_range(minx, maxx);
    yy = irandom_range(miny, maxy);
    if (xx > room_width){xx = room_width;}
    if (yy > room_height){yy = room_height;}
    if (xx < 0){xx = 0;}
    if (yy < 0){yy = 0;}
    show_debug_message("Re-rolling random location");
    if (mp_grid_get_cell(global.mp_grid,x div 66,y div 66) == 0){break;}
}

//if the location is good to go, start the grid
if (mp_grid_get_cell(global.mp_grid,x div 66,y div 66) == 0){
    scr_grid_move(xx,yy,spd,path_action_stop);
    show_debug_message("Found a good place to move random("+string(xx)+", "+string(yy)+")");
}



