var; wallsurface=0; w=0;  //Variables for the Surface on which all the wall sprites will be put on, and the New Wall object that will be made.
wallsurface=surface_create(room_width,room_height+1);  //Prepare a surface as big as the room, adding an extra pixel vertically so we can have transparency.
global.wallopsprite = sprite_index;
surface_set_target(wallsurface);  //Prepare to draw on the surface.
draw_clear(c_white);  //Clear the entire surface with the desired transparent color.
with obj_wall{  //With all of the walls in the room...
    if object_index==obj_wall{  //If it's not inheriting from anything (you may want to handle slopes with their own combined slope object, for example...
        draw_sprite(sprite_index,-1,x,y);  //Draw their sprite on the surface at their location.
        instance_destroy();  //Then delete theirself.
    }
}
if sprite_exists(global.wallopsprite){sprite_delete(global.wallopsprite);}  //If there was a combined wall surface sprite made before, get rid of it.  This is crucial you store this, as these will build up if you don't get rid of them, and can crash the game.
global.wallopsprite=sprite_create_from_surface(wallsurface,0,0,surface_get_width(wallsurface),surface_get_height(wallsurface),true,false,0,0);  //Make a new sprite from the surface made of all the Wall objects.
w=instance_create(0,0,obj_wall);  //Make a brand new Wall object at the top left of the room;
w.sprite_index=global.wallopsprite;  //Set its sprite to the sprite made from the surface.
w.mask_index=w.sprite_index;  //Set its mask to its sprite.
surface_free(wallsurface);  //Free up the memory from that surface.
surface_reset_target();  //Reset the drawing location.
