///scr_scan_mp_grid(grid_id, cellsize);
//This script will scan the room and add the cells to the given location
//It fills up all voids and wall objects
var cellsize, hcells, vcells, grid_id;
grid_id = argument0;
cellsize = argument1;
hcells = room_width div cellsize;
vcells = room_height div cellsize;

//Add the cells that the path will avoid
mp_grid_add_instances(grid_id, obj_par_wall, false);

//scan the map for voids
for (var yy = 0; yy <= vcells; yy++) {
    for (var xx = 0; xx <= hcells; xx++) {
        if (!scr_check_tile(xx*cellsize,yy*cellsize)){
            mp_grid_add_cell(grid_id, xx, yy);
        }
    }
}
