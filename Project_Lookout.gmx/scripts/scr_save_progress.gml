///scr_save_progress(next_room);
if (file_exists(working_directory+"level_progress.sav")){file_delete("level_progress.sav");}
ini_open(working_directory+"level_progress.sav");
var saved_room = argument0;
ini_write_real("Level","room",saved_room); //save level
ini_write_real("Player Info","object", global.player); //save the player's object
ini_write_real("Player Info","hp", global.player.hp); //save player's hp
ini_write_string("Player Info","weapon", global.player.holding_gun); //save current gun
ini_write_string("Player Info","item", global.player.holding_item); //save current item
ini_write_string("Player Info","item_type",global.player.current_item_type); //item type
ini_write_real("Player Info","ammo", global.player.current_ammo); //save ammo
ini_close();
