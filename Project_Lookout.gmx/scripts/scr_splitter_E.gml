///scr_splitter_E()
//detects whether the splitter is activated and then shoots laser in certain direction
if (active) {
    laser_x = x+lengthdir_x(22,image_angle);
    laser_y = y+lengthdir_y(22,image_angle);
    dir = image_angle;
    scr_laser(2000,c_red);
}
