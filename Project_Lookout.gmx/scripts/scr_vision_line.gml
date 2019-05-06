///scr_vision_line(view_range, vision_angle)
var range = argument0;
var gamma = argument1; //The view angle or range
var x1 = x + lengthdir_x(range, image_angle - gamma/2);
var y1 = y + lengthdir_y(range, image_angle - gamma/2);
var x2 = x + lengthdir_x(range, image_angle + gamma/2);
var y2 = y + lengthdir_y(range, image_angle + gamma/2);

if (instance_exists(global.player)){
   var inst = instance_nearest(x, y, global.player);
   var inst2 = instance_nearest(x, y, obj_deadbody);
   if ((!collision_line(x,y,inst.x,inst.y,obj_par_wall,false,true) && point_in_triangle(inst.x, inst.y, x, y, x1, y1, x2, y2)) || (place_meeting(x,y,global.player))){
       return 'I see you';//Makes the vision cone and out put the result
   }
   else if (inst2 != noone &&!collision_line(x,y,inst2.x,inst2.y,obj_par_wall,false,true) && point_in_triangle(inst2.x, inst2.y, x, y, x1, y1, x2, y2)){
       return 'I see body';//Makes the vision cone and out put the result
   }
   else{return false;}
   
}
/*
if (instance_exists(obj_deadbody)){
   
   
   if (point_in_triangle(inst2.x, inst2.y, x, y, x1, y1, x2, y2)&&!collision_line(x,y,inst2.x,inst2.y,obj_par_wall,false,true)){
       return 'I see body';//Makes the vision cone and out put the result
   }
   else{return false;}
}
*/

