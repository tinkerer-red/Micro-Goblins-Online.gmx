/// scr_mod_backStab()


if (self.item_data[self.weap_num, weapon_type] = item_type_weapon_melee){
  
  var mod_count = scr_queue_has_mod_count(active_queue, scr_mod_backStab)
  
  var weaps_to_spawn = mod_count
  var max_angle = 360/(weaps_to_spawn+1)
  
  
  while ds_queue_size(self.recent_weap_queue) != 0{
    var _weap = ds_queue_dequeue(self.recent_weap_queue)
    
    for (var i = 1; i <= weaps_to_spawn; i++){
      
      var new_weap = scr_spawn_weapon(self.weap_num)
      
      ds_queue_enqueue(self.weap_queue, new_weap)
      
      ///set variables for new weapon
      var distance = ((self.sprite_width*self.image_xscale)/2 + (self.sprite_height*self.image_yscale)/2) /2 +1;
      var _dir = _weap.direction + (max_angle * i)
      
      xx = x+lengthdir_x(distance, _dir);
      yy = y+lengthdir_y(distance, _dir);
      
      owner_id = self.id
      new_weap.x = xx
      new_weap.y = yy
      new_weap.start_x = xx
      new_weap.start_y = yy
      new_weap.image_angle = _dir-45
      new_weap.direction = _dir
      new_weap.w_start_dir = _dir
      //new_weap.w_end_dir = _weap.w_start_dir-180
      //new_weap.dis = distance
      
    }
  }

  //reload the new weapons into the original queue
  if (mod_count = 1){
    if ds_queue_size(self.recent_weap_queue) = 0{
      ds_queue_copy(self.recent_weap_queue, self.weap_queue)
    }
  }
}

return true
