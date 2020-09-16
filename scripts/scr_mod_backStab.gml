/// scr_mod_backStab()


if (self.item_data[self.weap_num, weapon_type] = weapon_type_melee){
  var _dir = direction-135
  if (_dir >= 360) {_dir -= 360}
  if (_dir < 0) {_dir += 360}
  
  var distance = ((self.sprite_width*self.image_xscale)/2 + (self.sprite_height*self.image_yscale)/2) /2 +1
  
  xx = x+lengthdir_x(distance, _dir);
  yy = y+lengthdir_y(distance, _dir);
  
  self.weap = scr_spawn_weapon(self.weap_num)
  //var weap = instance_create(xx, yy, obj_weapon);
  
  owner_id = self.id
  weap.x = xx
  weap.y = yy
  weap.start_x = xx
  weap.start_y = yy
  weap.image_angle = _dir
  weap.direction = _dir-45
  weap.w_start_dir = _dir
  weap.w_end_dir = weap.w_start_dir-180
  
  ds_priority_add(recent_weap_queue, weap, 2)
  ds_priority_add(weap_queue, weap, 2)
}

return true
