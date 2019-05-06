mp_grid_path(global.grid, path, x, y, last_loc_x, last_loc_y, true);
var aim_direction = angle_to_intercept_ext(60, sprite_width/2, 0, global.player, 0, 0, false, true);
var max_rotate_speed = char_speed;
var damping_factor = 1;
direction -= clamp(angle_difference(direction, aim_direction) * damping_factor, -max_rotate_speed, max_rotate_speed);
//direction = (image_angle + (sin(degtorad((point_direction(x, y, target.x + lengthdir_x(target.char_speed * point_distance(x, y, target.x, target.y) * 0.1, target.image_angle), target.y + lengthdir_y(target.char_speed * point_distance(x, y, target.x, target.y) * 0.1, target.image_angle))) - image_angle)) * 12));
//Make the AI maintain a distance to the player.
if point_distance(x, y, target.x, target.y) > vrange / 2 || collision_line(x, y, target.x, target.y, obj_wall, 0, 0) > 0 {
mp_potential_step_object(target.x, target.y, max_speed, obj_wall)
}
if (point_distance(x, y, target.x, target.y) < vrange / 1.5 && collision_line(x, y, target.x, target.y, obj_wall, 0, 0) < 0) {
mp_potential_step_object(target.x, target.y, -max_speed, obj_wall)
}
show_debug_message(string(seeing));
//Shoot the gun
if holding_gun != "None" && alarm[0] <= 0 {
if (collision_line(x, y, target.x, target.y, target, 0, 0)) {
current_ammo -= 1;
alarm[0] = firerate;
scr_Shoot();
}
}
