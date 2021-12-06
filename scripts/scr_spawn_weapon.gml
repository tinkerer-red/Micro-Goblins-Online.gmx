///scr_spawn_weapon(weapon_slot)

///find the data for the weapon slot
//
//
//
//
//

with (obj_weapon)
{
  if owner_id = id
  {instance_destroy()}
}

//var weap;

var distance = ((self.sprite_width*self.image_xscale)/2 + (self.sprite_height*self.image_yscale)/2) /2 +1;
self.spawn_x = x+lengthdir_x(distance, self.direction);
self.spawn_y = y+lengthdir_y(distance, self.direction);



var weap = instance_create(spawn_x, spawn_y, obj_weapon);


weap.owner_id = id

weap.w_name = self.item_data[weap_num, weapon_name]
weap.w_type = self.item_data[weap_num, weapon_type]
weap.sprite_index = self.item_data[weap_num, weapon_sprite]
weap.sprite_proj = self.item_data[weap_num, weapon_proj_sprite]
weap.sprite_aoe = self.item_data[weap_num, weapon_aoe_sprite]

if (weap.w_type != item_type_weapon_range)
{
  weap.w_start_dir = self.direction
  if (weap.w_start_dir >= 360) {weap.w_start_dir -= 360}
  
  weap.w_end_dir = weap.w_start_dir-180
  if (weap.w_end_dir <= 0) {weap.w_end_dir += 360}
  
} else { //if melee_ranged
  weap.w_start_dir = self.direction
  /// need to make a bow and test this
  //might need to flip image aswell?
}

weap.image_angle = weap.w_start_dir-45
weap.direction = self.direction
weap.dis = distance
//weap.proj_speed += spd

weap.active_w_cooldown = self.active_w_spawn_time_out

weap.w_damage = self.active_w_damage
weap.w_knockback = self.active_w_knockback

return weap;
