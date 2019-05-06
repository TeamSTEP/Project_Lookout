///scr_render(offset);
var offset = argument0;

//add the objects to deactivate when it is out of view
instance_deactivate_object(obj_par_wall);
instance_deactivate_object(obj_deadbody);
instance_deactivate_object(obj_laserbeam);
if (!global.dark){
    instance_deactivate_object(obj_light);
    instance_deactivate_object(obj_light_blinking);
}

instance_activate_region(view_xview[0] - offset,view_yview[0] - offset,view_wview[0] + offset*2,view_hview[0] + offset*2,true);
