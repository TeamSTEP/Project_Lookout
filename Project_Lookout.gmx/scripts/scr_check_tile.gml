///scr_check_tile(x,y);
//this script will check to see if the given coordinates have the
//listed layers (or tiles) in, and will return true if there is,
//and return false if there is no tile in the coordinates

var tile, i, xx, yy;
xx = argument0;
yy = argument1;
//List of layers that is considered as tiles
tile = 1000000; //1000000 is noisy floor, and 999999 is quiet floor
if (tile_layer_find(tile,xx,yy)!= -1 || tile_layer_find(tile-1,xx,yy)!= -1){
       return true;
}
else {return false;}
/*
var m;
for (m = 0; m < array_length_1d(tile); i++){
    if (tile_layer_find(tile[m],xx,yy)!= -1){
       return true;
    }
    else {return false;}
}
*/

