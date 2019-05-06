///scr_spawn_objects(cellsize,spawn chance)
//This script will spawn the objects in to the selected coordinates at a
//given chance.
var cellsize = argument0;
var spawn_chance = argument1;
var width = (room_width div cellsize);
var height = (room_height div cellsize);

// Set up some constants
var FLOOR = -5;
var WALL = -6;
var VOID = -7;

// Draw the level
for (var yy = 0; yy < height; yy++) {
    for (var xx = 0; xx < width; xx++) {
        if (ds_grid_get(global.ds_grid, xx, yy) == FLOOR) {
            //Make sure it spawns in the middle of the grid
            var ex = xx * cellsize+cellsize/2;
            var ey = yy * cellsize+cellsize/2;
            // Spawn the enemy at a good place
            var item = choose(obj_weapon_rifle,obj_weapon_pistol,obj_weapon_shotgun);
            if (irandom(spawn_chance) == spawn_chance){ //spawn in 1/n chance
                instance_create(ex,ey,item);
            }
            
            if (point_distance(ex,ey,global.player.x,global.player.y) > cellsize*4.5 && irandom(spawn_chance) == spawn_chance){
                //var enemy = instance_create(ex,ey,choose(obj_enemy,obj_laser_bomber));
                var enemy = instance_create(ex,ey,obj_enemy);
                enemy.holding_gun = "Pistol";
                enemy.current_ammo = 15;
                show_debug_message("Spawning enemy at " + string(ex)+", "+string(ey));
            }
            
            if (global.dark){
                if (irandom(150) == 150){ //spawn in 1/n chance
                    var light = choose(obj_light,obj_light_blinking);
                    instance_create(ex,ey,light);
                }
            }
        }
    }
}


