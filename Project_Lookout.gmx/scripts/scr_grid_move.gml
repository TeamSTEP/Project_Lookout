///scr_grid_move(target_x,target_y, spd, endaction);
var target_x, target_y, spd;
target_x = argument0;
target_y = argument1;
spd = argument2;
endact = argument3;

mp_grid_path(global.mp_grid, path, x, y, target_x, target_y, true);
path_start(path, spd, endact, true);
