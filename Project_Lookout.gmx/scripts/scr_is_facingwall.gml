///scr_is_facingwall(distance);
var dis = argument0;
var xx = x + lengthdir_x(dis, image_angle);
var yy = y + lengthdir_y(dis, image_angle);
if !place_free(xx,yy){
   return true;
}
else {return false;}
