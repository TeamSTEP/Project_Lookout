///scr_particle_laser(color)
//get color variable
cc = argument0

//create particle system
PartSystem = part_system_create()

//create and define particle type
Particle = part_type_create();
part_type_shape(Particle,pt_shape_spark);
part_type_size(Particle,0.1,0.2,0,0);
part_type_scale(Particle,1,1);
part_type_color1(Particle,cc);
part_type_alpha3(Particle,1,1,0);
part_type_speed(Particle,0.40,1,-0.01,0);
part_type_direction(Particle,0,359,0,0);
part_type_gravity(Particle,0,270);
part_type_orientation(Particle,0,0,0,0,1);
part_type_blend(Particle,1);
part_type_life(Particle,10,20);

//create emitter for particle system
PartEmitter = part_emitter_create(PartSystem);
