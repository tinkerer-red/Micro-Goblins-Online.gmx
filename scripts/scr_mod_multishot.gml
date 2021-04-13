/// scr_mod_multishot()

//show_debug_message("scr_mod_multishot")

if !to_much_lag(){
  
  if (w_type = weapon_type_range) || (melee_ranged > 0){
    
    var mod_count = scr_queue_has_mod_count(active_queue, scr_mod_multishot)
    
    var shots_to_spawn = mod_count
    
    var max_angle = 20*shots_to_spawn
    var _dir = max_angle/shots_to_spawn
    
    
    while ds_queue_size(self.recent_proj_queue) != 0{
      var _proj = ds_queue_dequeue(self.recent_proj_queue)
      
      for (var i = 0; i < shots_to_spawn; i++){
        for (var j = -1; j < 2; j+=2){
        
          //make sure we haven't created to many projectiles
          var count = ds_queue_size(self.proj_queue)
          if count > 1000
          || (fps < 10){continue;}
          
          
          var new_proj = instance_create(x, y, obj_weap_proj)
          
          ds_queue_enqueue(self.proj_queue, new_proj)
          
          ///set variables for new projectile
          var self.distance = ((owner_id.sprite_width*owner_id.image_xscale)/2 + (owner_id.sprite_height*owner_id.image_yscale)/2) /2 +1
          new_proj.x = x+lengthdir_x(self.distance, _proj.direction+ (_dir*(i+1) * j) );
          new_proj.y = y+lengthdir_y(self.distance, _proj.direction+ (_dir*(i+1) * j) );
          new_proj.direction = point_direction(x,y,new_proj.x,new_proj.y)
          new_proj.owner_weap = id
        
        }
      }
    }
  }
  
  //reload the new projectiles into the original queue
  if (mod_count = 1){
    if ds_queue_size(self.recent_proj_queue) = 0{
      ds_queue_copy(self.recent_proj_queue, self.proj_queue)
    }
  }
  
}  
return true
