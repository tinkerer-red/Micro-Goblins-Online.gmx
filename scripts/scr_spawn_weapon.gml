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

var weap;

var distance = ((self.sprite_width*self.image_xscale)/2 + (self.sprite_height*self.image_yscale)/2) /2 +1
var self.xx = x+lengthdir_x(distance, self.direction);
var self.yy = y+lengthdir_y(distance, self.direction);


self.weap = instance_create(xx, yy, obj_weapon)


self.weap.owner_id = id

self.weap.w_name = self.item_data[self.weap_num, weapon_name]
self.weap.w_type = self.item_data[self.weap_num, weapon_type]
self.weap.sprite_index = self.item_data[self.weap_num, weapon_sprite]
self.weap.sprite_proj = self.item_data[self.weap_num, weapon_proj_sprite]

if (self.weap.w_type != weapon_type_range)
{
  self.weap.w_start_dir = self.direction+45
  if (self.weap.w_start_dir >= 360) {self.weap.w_start_dir -= 360}
  
  self.weap.w_end_dir = self.weap.w_start_dir-180
  if (self.weap.w_end_dir <= 0) {self.weap.w_end_dir += 360}
  
} else { //if ranged
  self.weap.w_start_dir = self.direction-45
  /// need to make a bow and test this
  //might need to flip image aswell?
}

self.weap.image_angle = self.weap.w_start_dir
self.weap.direction = self.direction
self.weap.dis = distance
self.weap.proj_speed += spd

self.weap.w_damage = self.active_w_damage
self.weap.w_knockback = self.active_w_knockback

return self.weap;
