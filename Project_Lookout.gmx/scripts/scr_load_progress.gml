///scr_load_progress(starting_level);
ini_open(working_directory+"level_progress.sav");
var start_room = argument0; //The first room of that stage
var current_room = ini_read_real("Level","room",start_room);
global.player = ini_read_real("Player Info", "object", obj_player);
global.player.hp = ini_read_real("Player Info","hp", 5);
global.player.holding_gun = ini_read_string("Player Info", "weapon", "None");
global.player.holding_item = ini_read_string("Player Info", "item", "None");
global.player.current_item_type = ini_read_string("Player Info", "item_type", "weapon");
global.player.current_ammo = ini_read_real("Player Info","ammo",-1);
ini_close();
if (room != current_room){room_goto(current_room);}
//else{exit;}
