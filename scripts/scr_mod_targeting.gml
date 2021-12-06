///scr_mod_targeting
//
//ranged
//proj spawn modifier

//show_debug_message("scr_mod_targeting")

if (object_index = obj_weapon) && (w_type = item_type_weapon_range || melee_ranged > 0){
  //show_debug_message("made it inside the effects!")
  
  var mod_count = scr_queue_has_mod_count(active_queue, scr_mod_targeting)
  
  if !variable_instance_exists(self, "mod_targeting_start"){
    mod_targeting_start = true;
    mod_targeting_move_speed = ((w_range/4)/room_speed) + ((w_range/4)/room_speed)*mod_count //3 tiles per second + 1 tile per sec per extra mod
    mod_targeting_timer = room_speed + (room_speed*0.5)*(mod_count-1)
    
    //draw target code
    is_targeting = true;
    mod_targeting_target_x = x+lengthdir_x(w_hype, direction)
    mod_targeting_target_y = y+lengthdir_y(w_hype, direction)
    mod_targeting_target_max_dist = w_range
  }
  
  if (owner_id.item_a || owner_id.item_b || owner_id.item_c)
  && (mod_targeting_timer > 0){
    
    if (mod_targeting_start = true){
      mod_targeting_start = false;
      
      //decrement the timer
      mod_targeting_timer -= 1*lag()
      show_debug_player(0, "mod_targeting_timer = "+string(mod_targeting_timer))
      
      //move the target into the direction the player is currently pressing
      if not ((!ceil(owner_id.right) && !ceil(owner_id.left) && !ceil(owner_id.down) && !ceil(owner_id.up)) || 
      (owner_id.right == owner_id.left && owner_id.up == owner_id.down)){
        
        mod_targeting_target_x += (owner_id.right - owner_id.left) * mod_targeting_move_speed *lag()
        mod_targeting_target_y += (owner_id.down - owner_id.up) * mod_targeting_move_speed *lag()
        
        //pull it back inside the radius
        if (point_distance(mod_targeting_target_x, mod_targeting_target_y, owner_id.x, owner_id.y) > mod_targeting_target_max_dist){
          var target_dir = point_direction(owner_id.x, owner_id.y, mod_targeting_target_x, mod_targeting_target_y)
          mod_targeting_target_x = owner_id.x+lengthdir_x(mod_targeting_target_max_dist, target_dir)
          mod_targeting_target_y = owner_id.y+lengthdir_y(mod_targeting_target_max_dist, target_dir)
          
        }
      }
    }
    
  }else{ //when the timer is finished or the button in released
    
    //find the relative angle of the weapon
    var _dist = point_distance(x, y, owner_id.x, owner_id.y);
    direction = point_direction(owner_id.x, owner_id.y, mod_targeting_target_x, mod_targeting_target_y)
    image_angle = direction-45
    x = owner_id.x + lengthdir_x(_dist, direction)
    y = owner_id.y + lengthdir_y(_dist, direction)
    
    while ds_queue_size(self.recent_proj_queue) != 0{
      var _proj = ds_queue_dequeue(self.recent_proj_queue);
      var _dist = point_distance(_proj.x, _proj.y, owner_id.x, owner_id.y);
      _proj.x = owner_id.x + lengthdir_x(_dist, direction)
      _proj.y = owner_id.y + lengthdir_y(_dist, direction)
      
      _proj.direction = direction
      _proj.image_angle = image_angle
      
      ///// Synergies
      /*
      if AOE/exsplosive || airstrike || Teleport{
        _proj.w_range = point_distance(mod_targeting_target_x, mod_targeting_target_y, owner_id.x, owner_id.y)
      }
      */
    }
    
    //add the projectiles back into the queue
    ds_queue_copy(self.recent_proj_queue, self.proj_queue)
    //show_debug_message("ds_queue_size(proj_queue) = "+string(ds_queue_size(proj_queue)))
    //show_debug_message("ds_queue_size(recent_proj_queue) = "+string(ds_queue_size(recent_proj_queue)))
    
    is_targeting = false
    
    return true
  }
  
  if (mod_count = 1){
    mod_targeting_start = true;
  }else{ //if we have more then a single mod in the queue remove them, because ideally we never need more then a single mod to handle anything
    return true
  }
}else{
  //show_debug_message("target returned true 2")
  return true;
}
