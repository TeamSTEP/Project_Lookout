if (holding_gun != "Laser"){
    var b1, b2, b3, xx, yy, i
    i = random(60) - sprite_width/2;
    xx = x+lengthdir_x(sprite_width/2+50,image_angle);
    yy = y+lengthdir_y(sprite_height/2+50,image_angle);
    b1 = instance_create(xx,yy,obj_bullet); //create the bullet
    b1.direction = image_angle;
    b1.image_angle = image_angle;
    b1.damage = damage;
    instance_create(xx,yy,obj_muzzle)
    audio_play_sound(weapon_sound, 1, false);
    
    if (holding_gun != "Shotgun"){
        //Now we will create the bullet casing as a nice special effect
        with (instance_create(x + i, y + i, obj_bullet_shell)){
            image_index = 0;
            direction = (b1.image_angle + 90)+ random(100);
            image_angle = b1.direction - 90;
        }
    }
    
    if (holding_gun == "Shotgun"){
        b2 = instance_create(xx,yy,obj_bullet);
        b3 = instance_create(xx,yy,obj_bullet);
        b2.direction = image_angle + random(5);
        b3.direction = image_angle - random(5);
        b2.image_angle = image_angle;
        b3.image_angle = image_angle;
        b2.damage = damage;
        b3.damage = damage;
        with (instance_create(x + i, y + i, obj_bullet_slug)){
            image_index = 1;
            direction = (b1.image_angle + 90)+ random(100);
            image_angle = b1.direction - 90;
        }
    }
}
else{
    var laser_beam = instance_create(x,y,obj_laserbeam);
    laser_beam.host = id;
    laser_beam.dis = sprite_width/2 + 30;
    laser_beam.dir = image_angle;
    //alarm[0] = 0;
}




