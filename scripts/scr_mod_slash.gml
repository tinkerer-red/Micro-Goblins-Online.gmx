///scr_mod_slash

/* This script is used to animate the melee weapon for a slash
     attack.
   
   Make sure to account for player direction as the sprite will
     rotate in different styles based on the direction it rotated
     to.
   
   Returns: Bool (True when animation is finished, False for any other state)
*/

//if !variable_instance_exists(self, "mod_slash_start"){
//  mod_slash_start = true;
//}

//var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_slash)


if (object_index = obj_weapon) && (w_type = weapon_type_melee){
  returned = false
  
  
  if !variable_instance_exists(self.id, "anim_slash_start") {anim_slash_start = true}
  
  
  //set the animation variables
  if (anim_slash_start)
  {
    // anim_time is used to equate exactly how many frames the animation needs to take
    var speed_mods = slowness - swiftness
    anim_slash_time = anim_attack_time //ceil(room_speed * ((0.01*power(speed_mods,2)) + (0.15*speed_mods) + 1))
    
    // anim_timer is used to equate where the sin/cos wave currently is
    anim_slash_timer = anim_slash_time
    
    // lastly max_-_multiplier is the maximum distance we want the axis to move, the cos/sin function would move it a parcent of the max
    anim_slash_max_direction_multiplier = 180
    
    // this variable is only used to make sure we only calculate the animation's variables once
    anim_slash_start = false
    
  }
  
  
//  if (mod_slash_start = true){
//    mod_slash_start = false;
  
    /// a negative number means we were facing right, and we're turning left
    var trav_dis_dir = (anim_slash_time/2 - anim_slash_timer )/anim_slash_time * anim_slash_max_direction_multiplier;
    
    //we invert this number just to make the player left handed
    var trav_dis_dir = w_start_dir+(trav_dis_dir);
    
    var x_off = owner_id.x - x;
    var y_off = owner_id.y - y;
    
    x += x_off + lengthdir_x(dis, trav_dis_dir);
    y += y_off + lengthdir_y(dis, trav_dis_dir);
    
    direction = point_direction(owner_id.x, owner_id.y, x, y)
    image_angle = direction-45
    
    
    if (anim_slash_timer <= 0){
      returned = true
      anim_slash_start = true
      
      anim_slash_time = 0
      anim_slash_timer = 0
      anim_slash_max_direction_multiplier = 0
    }
  
  
  //increment timer
  anim_slash_timer -= 1*lag() //*mod_count
//  }
  
//  if (mod_count = 0){
//    mod_slash_start = true;
//  }

  return returned
  
}else{ //if not melee or weapon
  return true
}



  
