///scr_wave(from, to, duration_sec, offset)
//Returns a value that will wave back and forth between [from-to] over [duration] seconds
//Examples
//        image_angle = scr_wave(-45, 45, 1, 0) -> rock back and forth 90 degrees in a second
//        x = scr_wave(-10, 10, 0.25, 0)        -> move left and right quickly

//        This one will make the image jelly-like
//        image_xscale = scr_wave(0.5, 2.0, 1.0, 0.0)
//        image_yscale = scr_wave(2.0, 0.5, 1.0, 0.0)

var a4 = (argument1 - argument0) * 0.5;
return argument0 + a4 + sin((((current_time * 0.001) + argument2 * argument3) / argument2) + (pi*2)) * a4;

