///scr_splitter_NE()
//detects whether the splitter is activated and then shoots laser in certain direction
if (active) {
    laser_x = x+lengthdir_x(21,image_angle+45)+lengthdir_x(1,image_angle+180);
    laser_y = y+lengthdir_y(21,image_angle+45);
    dir = image_angle+45;
    scr_laser(2000,c_red);
}
