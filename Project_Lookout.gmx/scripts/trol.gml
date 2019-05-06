///scr_Controls()
//Controller Type
if (global.con_type == "PC") {
//Aiming with mouse
image_angle = point_direction(x, y, mouse_x, mouse_y);
//this code is the shooting button (left mouse button)
if (mouse_check_button(mb_left)) {
if (!shooting && current_ammo > 0) {
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
aiming = true;
}
//Movement keys (OLD)
/*
if(keyboard_check(ord("W"))) {vspeed -= char_speed};
if(keyboard_check(ord("S"))) {vspeed += char_speed};
if(keyboard_check(ord("A"))) {hspeed -= char_speed};
if(keyboard_check(ord("D"))) {hspeed += char_speed};
    
if(keyboard_check(vk_control)){max_speed = 4;} //Sneaking key
else{max_speed = 8;}
if (speed > max_speed){speed = max_speed;};
*/
//Movement keys (NEW)
var move_speed_this_frame = max_speed * global.seconds_passed;


var move_xinput = 0;
var move_yinput = 0;

for (var i = 0; i < array_length_1d(movement_inputs); i++) {
var this_key = movement_inputs[i];
if keyboard_check(this_key) {
var this_angle = i * 90;
move_xinput += lengthdir_x(1, this_angle);
move_yinput += lengthdir_y(1, this_angle);
}
}

var moving = (point_distance(0, 0, move_xinput, move_yinput) > 0);
if moving {
var move_dir = point_direction(0, 0, move_xinput, move_yinput);
scr_movement(move_speed_this_frame, move_dir);
max_speed = 400;
char_speed = 2;
if (keyboard_check(vk_control)) {
max_speed = 200;
char_speed = 1;
} //Sneaking key
}else{
char_speed = 0;

}
}

if (global.con_type == "Mobile") {
//Player direction
if !vstick_check(2) {
image_angle = vstick_get_direction(1);
}
else {
image_angle = vstick_get_direction(2);
}
speed = vstick_get_deviation(1) * 8;
direction = vstick_get_direction(1);
if speed > 5 {
char_speed = 2;
}
else if speed <= 4 {
char_speed = 1;
}
if speed < 1 {
char_speed = 0;
}
//this code is the shooting button (right joystick)
if (vstick_get_deviation(2) > 0.9) {
if (!shooting && current_ammo > 0) {
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
aiming = true;
}
//This is for joystick wall collision
if (place_meeting(x + hspeed, y, obj_wall)){ //If my player is about to horizontally collide with a wall.
while(!place_meeting(x + sign(hspeed), y, obj_wall)){ //While we're not exactly 1 pixel away from the wall.
x += sign(hspeed); //Move 1 pixel in the direction towards the wall.
}
hspeed = 0; //Stop moving horizontally.
}

if (place_meeting(x, y + vspeed, obj_wall)){ //If my player is about to virtically collide with a wall.
while(!place_meeting(x, y + sign(vspeed), obj_wall)){ //While we're not exactly 1 pixel away from the wall.
y += sign(vspeed); //Move 1 pixel in the direction towards the wall.
}
vspeed = 0; //Stop moving virtically
}
}

if (global.con_type == "Console") {

}

//Keys that is used for all platforms


//This controlls the drag and pan the screen with the right button of the mouse
// start:
if (mouse_check_button_pressed(mb_right)) {
drag_x = mouse_x
drag_y = mouse_y
global.view_timer = room_speed;
view_object = noone;
}
// update:
if (mouse_check_button(mb_right)) {
// actual dragging logic:
view_xview = drag_x - (mouse_x - view_xview)
view_yview = drag_y - (mouse_y - view_yview)
// make sure view doesn't go outside the room:
view_xview = max(0, min(view_xview, room_width - view_wview))
view_yview = max(0, min(view_yview, room_height - view_hview))
}
//This will allow the camera to view back to the character after some time(global.view_timer)
else {
if (global.view_timer != 0) {
global.view_timer -= 1;
}
}
if global.view_timer <= 0 {
view_object = global.player;
view_hspeed = 35;
view_vspeed = 35;
}
//This code throws the currently holding gun away
if (keyboard_check(ord("Q")) && holding_gun != "None") {
var throw_gun, xx, yy
xx = x + lengthdir_x(sprite_width / 2 + 50, image_angle);
yy = y + lengthdir_y(sprite_height / 2 + 50, image_angle);
throw_gun = instance_create(xx, yy, weapon_object)
throw_gun.ammo = current_ammo;
throw_gun.speed = 5;
throw_gun.direction = (image_angle);
throw_gun.image_angle = (image_angle + 90);
throw_gun.thrown = true;

current_ammo = -1;
holding_gun = "None";
}
if (keyboard_check(vk_control)){standing = false;}
else {standing = true;}
