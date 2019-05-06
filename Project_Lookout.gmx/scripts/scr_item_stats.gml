//Gun Stats
switch (holding_gun) {
case ("None"):
firerate = 0;
damage = 0;
max_ammo = -1;
weapon_object = noone;
weapon_sound = sd_pistol;

break;

case ("Pistol"):
firerate = 30; //Shooting per frame, 60 = 1 second
damage = 5;
max_ammo = 15;
weapon_object = obj_weapon_pistol;
weapon_sound = sd_pistol;
weapon_sprite = spr_weapon_pistol;
break;

case ("Rifle"):
firerate = 10;
damage = 5;
max_ammo = 30;
weapon_object = obj_weapon_rifle;
weapon_sound = sd_rifle;
weapon_sprite = spr_weapon_rifle;
break;

case ("Shotgun"):
firerate = audio_sound_length(sd_shotgun) * room_speed;
damage = 5;
max_ammo = 8;
weapon_object = obj_weapon_shotgun;
weapon_sound = sd_shotgun;
weapon_sprite = spr_weapon_shotgun;
break;

case ("Laser"):
firerate = 0;
damage = 0;
max_ammo = -1;
weapon_object = obj_weapon_laser;
weapon_sound = sd_laser;
weapon_sprite = spr_weapon_laser;
break;
}
//Item Stats
switch (holding_item){
case ("None"):
item_damage = 0;
item_object = noone;
break;

case ("Glass Bottle"):
item_damage = 2;
item_object = obj_item_glass;
item_sprite = spr_item_glass;
break;

}
