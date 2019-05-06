///scr_laser_detect(object,notme);
//Returns the instance id of an object that the laser is pointing at
//And will return noone if nothing is found
//object: which objects to look for (or all), real
//notme: if true, ignore the calling instance, bool
var xx, yy, precision,object,notme,sx,sy,inst,i,prec,x_end,y_end;
xx = laser_x; //Laser starting point x
yy = laser_y; //Laser starting point y
precision = global.laser_prec; //how precise the raycasting is. the smaller number is more precise but takes more memory
//two sets of coords of where the laser ends
x_end = xx+lengthdir_x(dis+precision,dir);
y_end = yy+lengthdir_y(dis+precision,dir);

object = argument0;
notme = argument1;
sx = x_end - xx;
sy = y_end - yy;
prec = true;
inst = collision_line(xx,yy,x_end,y_end,object,prec,notme);

if (inst != noone) {
    while ((abs(sx) >= 1) || (abs(sy) >= 1)) {
        sx /= 2;
        sy /= 2;
        i = collision_line(xx,yy,x_end,y_end,object,prec,notme);
        if (i) {
            x_end -= sx;
            y_end -= sy;
            inst = i;
        }
        else{
            x_end += sx;
            y_end += sy;
        }
    }
}
return inst;
