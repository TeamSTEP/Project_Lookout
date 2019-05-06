///scr_splitter_SE()
//detects whether the splitter is activated and then shoots laser in certain direction
if (active) {
    laser_x = x+lengthdir_x(20,image_angle-45);
    laser_y = y+lengthdir_y(20,image_angle-45);
    dir = image_angle-45;
    scr_laser(2000,c_red);
}
