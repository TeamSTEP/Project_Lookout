///scr_Controls()
if (!global.control){exit;}
//Controller Type
//PC keys
//################################################################################
if (global.con_type == "PC") {
    //Aiming with mouse
    image_angle = point_direction(x, y, mouse_x, mouse_y);
    //this code is the shooting button (left mouse button)
    var ax = x + lengthdir_x(sprite_width div 2 +30, image_angle);
    var ay = y + lengthdir_y(sprite_height div 2 + 30, image_angle);
    if (mouse_check_button(mb_left)) {
        if (!shooting && current_ammo > 0 && place_free(ax,ay) && current_item_type == 'weapon') {
            current_ammo -= 1;
            shooting = true;
            alarm[0] = firerate;
            scr_Shoot();
        }
        if (!shooting && current_ammo = 0) {
            alarm[0] = 30;
            shooting = true;
            audio_play_sound(sd_no_ammo, 0, false);
        }
        if (holding_gun == "Laser" && place_free(ax,ay)){scr_Shoot();}
    }
    
    //Movement keys
    hspeed = (keyboard_check(ord("D")) - keyboard_check(ord("A"))) * max_speed;
    vspeed = (keyboard_check(ord("S")) - keyboard_check(ord("W"))) * max_speed;
    
    //Throw currently holding gun away
    if (current_item_type == 'weapon'){ //for throwing weapons
        if (keyboard_check(ord("Q")) && holding_gun != "None") {
            throwing_power = scr_wave(0.1, 1, 0.5,0);
        }
        if (keyboard_check_released(ord("Q")) && holding_gun != "None"){
            var throw_gun, xx, yy
            xx = x + lengthdir_x(sprite_width / 2 + 50, image_angle);
            yy = y + lengthdir_y(sprite_height / 2 + 50, image_angle);
            if (place_free(xx, yy)){
                throw_gun = instance_create(xx, yy, weapon_object);
                throw_gun.ammo = current_ammo;
                throw_gun.speed = 10 * throwing_power;
                throw_gun.direction = (image_angle);
                throw_gun.image_angle = (image_angle + 90);
                if (throwing_power > 0.2){throw_gun.thrown = true;}
                current_ammo = -1;
                holding_gun = "None";
            }
            throwing_power = 0;
        }
    }
    else{
        if (keyboard_check(ord("Q")) && holding_item != "None") {
            throwing_power = scr_wave(0.1, 1, 0.5,0);
        }
        if (keyboard_check_released(ord("Q")) && holding_item != "None"){
            var throw_item, xx, yy
            xx = x + lengthdir_x(sprite_width / 2 + 50, image_angle);
            yy = y + lengthdir_y(sprite_height / 2 + 50, image_angle);
            if (place_free(xx, yy)){
                throw_item = instance_create(xx, yy, item_object);
                throw_item.speed = 10 * throwing_power;
                throw_item.direction = (image_angle);
                throw_item.image_angle = (image_angle + 90);
                if (throwing_power > 0.2){throw_item.thrown = true;}
                holding_item = "None";
            }
            throwing_power = 0;
        }
    }
    //Switch holding item key
    if (!obj_control.dragging_mode && keyboard_check_pressed(ord("E"))){
        if (current_item_type == 'throwing'){current_item_type = 'weapon';}
        else{current_item_type = 'throwing';}
    }

}
//Mobile keys
//################################################################################
if (global.con_type == "Mobile") {
    //Player direction
    if (!obj_control.dragging_mode){
        if (!vstick_check(2)){
            image_angle = vstick_get_direction(1);
        }
        else{image_angle = vstick_get_direction(2);}
    }
    else{image_angle = point_direction(x,y,mouse_x,mouse_y);}
    direction = vstick_get_direction(1);
    speed = vstick_get_deviation(1) * max_speed;
    

    //this code is the shooting button (right joystick)
    if (vstick_get_deviation(2) > 0.9 && current_item_type == 'weapon') {
        var sx = x + lengthdir_x(sprite_width div 2, image_angle);
        var sy = y + lengthdir_y(sprite_height div 2, image_angle);
        if (!shooting && current_ammo > 0 && place_free(sx,sy)) {
            current_ammo -= 1;
            shooting = true;
            alarm[0] = firerate;
            scr_Shoot();
        }
        if (!shooting && current_ammo = 0) {
            alarm[0] = 30;
            shooting = true;
            audio_play_sound(sd_no_ammo, 0, false);
        }
        if (holding_gun == "Laser" && place_free(sx,sy)){scr_Shoot();}
    }
    
    //throwing away weapons
    if (current_item_type == 'weapon' && holding_gun != "None"){
        //Drag to throw
        var dist = point_distance(x,y,mouse_x,mouse_y);
        var max_dis = 500;
        var find_div = vstick_check(1);
        if (dist > max_dis) {dist = max_dis;}
        if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x,mouse_y,id)){
            obj_control.dragging_mode = true;
        }
        if (obj_control.dragging_mode){
            throwing_power = dist / max_dis;
            if (mouse_check_button_released(mb_left)){
                if (dist < sprite_height){
                    obj_control.dragging_mode = false;
                }
                else{
                    ///Throw weapon
                    var throw_gun, xx, yy
                    xx = x + lengthdir_x(sprite_width / 2 + 50, image_angle);
                    yy = y + lengthdir_y(sprite_height / 2 + 50, image_angle);
                    if (place_free(xx, yy)){
                        throw_gun = instance_create(xx, yy, weapon_object);
                        throw_gun.ammo = current_ammo;
                        throw_gun.speed = 10 * throwing_power;
                        throw_gun.direction = (image_angle);
                        throw_gun.image_angle = (image_angle + 90);
                        if (throwing_power > 0.2){throw_gun.thrown = true;}
                        current_ammo = -1;
                        holding_gun = "None";
                    }
                    obj_control.dragging_mode = false;
                }
            }
        }
        //Throw weapon with double tap
        else if (device_mouse_check_button(0,mb_right) || device_mouse_check_button(1,mb_right)){
            var throw_gun, xx, yy
            xx = x + lengthdir_x(sprite_width / 2, direction + 180);
            yy = y + lengthdir_y(sprite_height / 2, direction + 180);
            if (place_free(xx, yy)){
                throw_gun = instance_create(xx, yy, weapon_object);
                throw_gun.ammo = current_ammo;
                throw_gun.speed = 4;
                throw_gun.direction = (direction + 180);
                throw_gun.image_angle = (image_angle + 90);
                if (throwing_power > 0.2){throw_gun.thrown = true;}
                current_ammo = -1;
                holding_gun = "None";
            }
        }
    }
    //throwing away items
    if (current_item_type == 'throwing' && holding_item != "None"){
        //Drag to throw
        var dist = point_distance(x,y,mouse_x,mouse_y);
        var max_dis = 500;
        if (dist > max_dis) {dist = max_dis;}
        if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x,mouse_y,id)){
            obj_control.dragging_mode = true;
        }
        if (obj_control.dragging_mode){
            throwing_power = dist / max_dis;
            if (mouse_check_button_released(mb_left)){
                if (dist < sprite_height){
                    obj_control.dragging_mode = false;
                }
                else{
                    ///Throw item
                    var throw_item, xx, yy
                    xx = x + lengthdir_x(sprite_width / 2 + 50, image_angle);
                    yy = y + lengthdir_y(sprite_height / 2 + 50, image_angle);
                    if (place_free(xx, yy)){
                        throw_item = instance_create(xx, yy, item_object);
                        throw_item.speed = 10 * throwing_power;
                        throw_item.direction = (image_angle);
                        throw_item.image_angle = (image_angle + 90);
                        if (throwing_power > 0.2){throw_item.thrown = true;}
                        holding_item = "None";
                    }
                    obj_control.dragging_mode = false;
                }
            }
        }
        //Throw item with double tap
        else if (device_mouse_check_button(0,mb_right) || device_mouse_check_button(1,mb_right)){
            var throw_item, xx, yy
            xx = x + lengthdir_x(sprite_width / 2 + 50, direction+180);
            yy = y + lengthdir_y(sprite_height / 2 + 50, direction+180);
            if (place_free(xx, yy)){
                throw_item = instance_create(xx, yy, item_object);
                throw_item.speed = 4;
                throw_item.direction = (direction+180);
                throw_item.image_angle = (image_angle + 90);
                if (throwing_power > 0.2){throw_item.thrown = true;}
                holding_item = "None";
            }
        }
    }
    //Switch holding item key
    if (!obj_control.dragging_mode && !vstick_check(2) && keyboard_check_pressed(ord("E"))){
        if (current_item_type == 'throwing'){current_item_type = 'weapon';}
        else{current_item_type = 'throwing';}
    }
}
//################################################################################
if (global.con_type == "Console") {
    exit;
}

//Keys that is used for all platforms
//################################################################################

//wall collision
if (!place_free(x+hspeed,y+vspeed)){
   if (!place_free(x+hspeed,y)){hspeed = 0;}
   if (!place_free(x,y+vspeed)){vspeed = 0;}
}



//Sneaking key
if (keyboard_check(vk_control)){standing = false;}
else {standing = true;}

if (!standing){max_speed = 4;}
else if (standing){max_speed = 8;}
if (speed > max_speed){speed = max_speed;}

