///scr_sound_detect(sound_range)
//scr_sound_detect will return true if the player is close and is making footsteps noise
var range = argument0;
var gun_sound, item_sound;
gun_sound[0] = sd_pistol;
gun_sound[1] = sd_rifle;
gun_sound[2] = sd_shotgun;
item_sound[0] = sd_glass;
item_sound[1] = sd_drop_gun;
item_sound[2] = sd_debris;

if (global.player != obj_deadbody){
   var inst = instance_nearest(x, y, global.player);
   var item = instance_nearest(x,y,obj_par_pickup);
   var m;
   //if player is near and there is a gun shot sound
   for (m = 0; m < array_length_1d(gun_sound); m++){
       if (inst.shooting && distance_to_object(inst) <= range * 2 && audio_is_playing(gun_sound[m])){
          return 'I hear gunshot';
       }
       
       else if (distance_to_object(inst) <= range && audio_is_playing(sd_footsteps_metal)){return 'I hear foot'}
       
       else if (item != noone){
            if (distance_to_object(item) <= range && item.thrown){
                var i;
                for (i = 0; i < array_length_1d(item_sound); i++){
                    if (audio_is_playing(item_sound[i])){return 'I hear item';}
                } 
            }
        }
   }
   
}
else{return false;}



