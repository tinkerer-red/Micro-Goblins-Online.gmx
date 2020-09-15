/// scr_mod_multishot()

if (w_type = weapon_type_range) || (ranged = true){
  while ds_queue_size(self.recent_proj_queue) != 0{
    var _proj = ds_queue_dequeue(self.recent_proj_queue)
    
    var shots_to_spawn = scr_queue_has_mod_count(active_queue, scr_mod_multishot)
    
    var max_angle = 20*shots_to_spawn
    var _dir = max_angle/shots_to_spawn
    
    for (var i = 0; i < shots_to_spawn; i++){
      for (var j = -1; j < 2; j+=2){
        var new_proj = instance_create(x, y, obj_weap_proj)
        
        ds_queue_enqueue(self.proj_queue, new_proj)
        ///set variables for new projectile
        var self.distance = ((owner_id.sprite_width*owner_id.image_xscale)/2 + (owner_id.sprite_height*owner_id.image_yscale)/2) /2 +1
        new_proj.x = x+lengthdir_x(self.distance, _proj.direction+ (_dir*(i+1) * j) );
        new_proj.y = y+lengthdir_y(self.distance, _proj.direction+ (_dir*(i+1) * j) );
        new_proj.direction = point_direction(x,y,new_proj.x,new_proj.y)
        
      }
    }
  }
}

return true
