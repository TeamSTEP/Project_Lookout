///scr_AI(vision_range, vision_angle, sound_range)
var target, vrange, hrange, seeing, hearing, vangle, alert_length;
//dir = direction;
target = instance_nearest(x, y, global.player);
item_loc = instance_nearest(x, y, obj_par_pickup);
vrange = argument0;
vangle = argument1;
hrange = argument2;
if (global.player != obj_deadbody){seeing = scr_vision_line(vrange, vangle);}
else {
    seeing = false;
    exit;
}
hearing = scr_sound_detect(hrange);
alert_length = 35; //How long the AI should be alerted in seconds

if (current_ammo > 0) {
    //Everything about the vision of the AI
    switch (seeing) {
        case ('I see you'):
            
            //mp_grid_path(global.grid, path, x, y, last_loc_x, last_loc_y, true); //update the path
            //Set the last known location of the target(player)
            last_loc_x = target.x;
            last_loc_y = target.y;
            state = 'chasing';
            //chasing is for the AI to chase the player
            //chasing = true;
            alarm[2] = (room_speed * alert_length) / 2; //State cool off
            alarm[1] = 2;
            //direction = point_direction(x,y,target.x,target.y);
            direction = scr_intercept_course(id, target, 25);
            //Make the AI maintain a distance to the player.
            if (!place_meeting(x, y, obj_par_wall) && point_distance(x, y, target.x, target.y) > vrange div 1.5) { //if player is close
                mp_potential_step_object(target.x, target.y, max_speed, obj_wall);
                //scr_grid_move(last_loc_x, last_loc_y, max_speed, path_action_stop);
            }
            else{path_end();} //Stop the path if it is moving
            if (!place_meeting(x, y, obj_par_wall) && point_distance(x, y, target.x, target.y) < 200) { //if player is close
                mp_potential_step_object(target.x, target.y, -max_speed, obj_wall);
            }
            show_debug_message(string(seeing));
            
            //aim and shoot the gun
            if (holding_gun != "None" && alarm[0] <= 0) {
                if (collision_line(x, y, x + lengthdir_x(vrange, image_angle), y + lengthdir_y(vrange, image_angle), target, 0, 1)) {
                    if (holding_gun != "Laser") {
                        current_ammo -= 1;
                        alarm[0] = firerate;
                    }
                    scr_Shoot();
                }
            }
        break;
        
        case ('I see body'):
            if (seeing != 'I see you' && state != 'chasing') {
                var body = instance_nearest(x, y, obj_deadbody);
                last_loc_x = body.x;
                last_loc_y = body.y;
                //direction = point_direction(x, y, last_loc_x, last_loc_y);
                scr_grid_move(last_loc_x, last_loc_y, max_speed, path_action_stop);
                state = 'alert';
            }
        break;
    }
    
    //Everything about the hearing of the AI
    //Mostly update last location, change state, look at the location.
    if (seeing != 'I see you') { //can only hear if AI is not seeing the player
        if (state != 'chasing') {
            switch (hearing) {
                case ('I hear gunshot'):
                    last_loc_x = target.x;
                    last_loc_y = target.y;
                    state = 'chasing';
                    //alarm[1] = 1; //alarm for moving towards the point
                    //scr_grid_move(last_loc_x, last_loc_y, max_speed, path_action_stop);
                    show_debug_message(string(hearing));
                break;
                
                case ('I hear foot'):
                    last_loc_x = target.x;
                    last_loc_y = target.y;
                    if (state == 'alert') {
                        scr_grid_move(last_loc_x, last_loc_y, max_speed, path_action_stop);
                    }
                    else{
                        state = 'question';
                        alarm[2] = room_speed * alert_length; //State cool off
                        scr_grid_move(last_loc_x, last_loc_y, char_speed, path_action_stop);
                    }
                    show_debug_message(string(hearing));
                break;
                
                case 'I hear item':
                    last_loc_x = item_loc.x - lengthdir_x(-64, image_angle);
                    last_loc_y = item_loc.y - lengthdir_y(-64, image_angle);
                    if (state != 'alert') {
                        state = 'question';
                    }
                    //mp_grid_path(global.grid, path, x, y, last_loc_x, last_loc_y, true);
                    alarm[2] = room_speed * alert_length; //Set cooldown for state
                    scr_grid_move(last_loc_x ,last_loc_y ,char_speed, path_action_stop);
                    //alarm[1] = 2; //alarm for moving towards the point
                    show_debug_message(string(hearing));
                break;
                
                default:
                    if (hearing != false) {
                        //direction = point_direction(x, y, last_loc_x, last_loc_y);
                        show_debug_message(string(hearing));
                    }
                break;
            }
        }
        
        switch (state) {
            case ('chasing'):
                view_range = 594;
                if (path_position == 1 || alarm[2] <= 0) {
                    state = 'alert';
                }
                if (alarm[2] > 0) {alarm[2]--;}
                scr_grid_move(last_loc_x, last_loc_y, max_speed, path_action_stop);
                show_debug_message("chasing enemy");
            break;
            
            case ('alert'):
                view_range = 594;
                if (path_position == 1) {
                    direction = scr_wave(vision_angle + 70, vision_angle - 70, 1, 0);
                    if (!timeline_running) {
                        timeline_index = tl_ai_searching;
                        timeline_position = 0;
                        timeline_loop = false;
                        timeline_running = true;
                    }
                }
            break;
            
            case ('question'):
                view_range = 500;
                if (alarm[2] > 0) {alarm[2]--;}
                if (path_position == 1) {
                    direction = scr_wave(vision_angle + 70, vision_angle - 70, 1, 0);
                    if (!timeline_running) {
                        timeline_index = tl_ai_searching;
                        timeline_position = 0;
                        timeline_loop = false;
                        timeline_running = true;
                    }
                }
                if (alarm[2] <= 0) {
                    state = 'none';
                    if (timeline_running) {
                        timeline_position = 0;
                        timeline_running = false;
                    }
                    alarm[1] = room_speed;
                    show_debug_message("state: question -> none");
                }
            
            break;
            case ('none'):
                if (x == post_x && y == post_y && patrol) {
                    path_start(post_path, char_speed, after_path, true);
                    mp_grid_path(global.mp_grid, path, x, y, last_loc_x, last_loc_y, true);
                    show_debug_message("on my post");
                }
            break;
        }
    }

}
if (current_ammo == 0 && holding_gun != "None") { //Throw the gun
    show_debug_message("I am out of ammo");
    var throw_gun, xx, yy
    xx = x + lengthdir_x(sprite_width / 2 + 50, image_angle + 90);
    yy = y + lengthdir_y(sprite_height / 2 + 50, image_angle + 90);
    if (place_free(xx, yy)) {
        throw_gun = instance_create(xx, yy, weapon_object);
        with(throw_gun) {
            ammo = other.current_ammo;
            speed = 5;
            direction = image_angle;
            image_angle = image_angle + 90;
            thrown = true;
        }
        current_ammo = -1;
        holding_gun = "None";
    }
    else{
        xx = x + lengthdir_x(sprite_width / 2 + 50, image_angle - 90);
        yy = y + lengthdir_y(sprite_height / 2 + 50, image_angle - 90);
        throw_gun = instance_create(xx, yy, weapon_object);
        with(throw_gun) {
            ammo = other.current_ammo;
            speed = 5;
            direction = image_angle;
            image_angle = image_angle + 90;
            thrown = true;
        }
        current_ammo = -1;
        holding_gun = "None";
    }
}
if (holding_gun == "None") { //If the AI has no gun in hand, it'll pick one up
    if (item_loc != noone && item_loc.ammo > 0) {
        last_loc_x = item_loc.x;
        last_loc_y = item_loc.y;
        scr_grid_move(last_loc_x, last_loc_y, max_speed, state = 'alert');
    }
    else {
        show_debug_message("There is no weapon to find");
        exit;
        //Add melee attack here to use when there is no weapon to pick up
    }
}
/*
if (holding_gun == "None") { //If the AI has no gun in hand, it'll pick one up
    var pickups = instance_number(obj_par_gun);
    for (var i = 0; i < pickups; i++){
        var w = scr_instance_nth_nearest(x,y,obj_par_gun,i);
        if (w.ammo > 0){
            last_loc_x = w.x;
            last_loc_y = w.y;
            //scr_grid_move(last_loc_x, last_loc_y, max_speed, path_action_reverse);
            break;
        }
    }
    scr_grid_move(last_loc_x, last_loc_y, max_speed, path_action_reverse);
}
*/


