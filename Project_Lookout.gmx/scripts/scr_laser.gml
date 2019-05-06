///scr_laser(length,color)
//This script calculates and draws where the laser is supposed to go using raycasting type collisions.
//Put the script in the Draw event and call it when you want to cast it
var xx, yy, length, color, precision;
xx = laser_x; //Laser starting point x
yy = laser_y; //Laser starting point y
length = argument0; //the maximum length of the laser (usually the whole room)
color = argument1; //the color of the laser
//dir = argument4; //the direction of the laser

precision = global.laser_prec; //how precise the raycasting is. the smaller number is more precise but takes more memory
draw_set_color(c_red);
draw_set_alpha(1);

//a for loop to check for collisions with wall and other objects
var i;

for(i=0;(i<length)&&(!collision_point(xx+lengthdir_x(i,dir),yy+lengthdir_y(i,dir),obj_par_wall,1,1))&&(!collision_point(xx+lengthdir_x(i,dir),yy+lengthdir_y(i,dir),obj_par_collision,1,1));i+=precision) {
    dis = i;
}

//two sets of coords of where the laser ends
var xx1 = xx+lengthdir_x(dis,dir);
var yy1 = yy+lengthdir_y(dis,dir);
var xx2 = xx+lengthdir_x(dis+precision,dir);
var yy2 = yy+lengthdir_y(dis+precision,dir);

//draw laser between coords
scr_draw_laser(xx,yy,xx2,yy2,1,color);

//Set the particles for the laser tip
scr_particle_laser(color);
//particles (not necessary)
part_type_color1(Particle,color);
part_emitter_region(PartSystem,PartEmitter,xx1,xx1,yy1,yy1,0,0);
part_emitter_burst(PartSystem,PartEmitter,Particle,1);

//checks if laser is colliding with mirror, and if it is then make the mirror reflect
if (collision_point(xx1,yy1,obj_par_mirror,0,1) || collision_point(xx2,yy2,obj_par_mirror,0,1)) {
    var inst = instance_nearest(xx1,yy1,obj_par_mirror);
    inst.laser_x = xx1;
    inst.laser_y = yy1;
    inst.dir = inst.v1 + (inst.v2 - dir);
    inst.dis = length - dis;
    with (inst) {scr_laser(dis,c_red);}
    
}

//checks if laser is colliding with splitter, then tells splitter to shoot out lasers
if (collision_point(xx1,yy1,obj_par_lasersplit,0,1) || collision_point(xx2,yy2,obj_par_lasersplit,0,1)) {
    var inst = instance_nearest(xx2,yy2,obj_par_lasersplit);
    inst.active = true;
    inst.dis = length - dis;
    inst.color = color;
    inst.alarm[0] = 2;
}
