///scr_save_dungeon(Save Name)
//it saves the grid information(value) of the level
var section = argument0;

ini_open("dungeon.ini");    // Open the INI

var dump = ds_grid_write(global.ds_grid);
ini_write_string(string(section),"dump",string(dump));

ini_close();    // Close the INI
