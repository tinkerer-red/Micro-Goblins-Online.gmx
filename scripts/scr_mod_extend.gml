///scr_mod_extend

/* This script is used to animate the melee weapon for an extend
     attack.
   
   Make sure to account for player direction as the sprite will
     rotate in different styles based on the direction it rotated
     to.
   
   Returns: Bool (True when animation is finished, False for any other state)
*/
//if !variable_instance_exists(self, "mod_extend_start"){
//  mod_extend_start = true;
//}

//var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_extend)

//if (mod_extend_start = true){
//  mod_extend_start = false;
  
  if (object_index = obj_weapon) && (w_type = weapon_type_melee){
    returned = false
    
    if (anim_attack_timer < (anim_attack_time*0.2)){
      if !variable_instance_exists(self.id, "anim_extend_start") {
        anim_extend_start = true
      }
      
      
      var mod_count = scr_queue_has_mod_count(self.step_event_queues_temp, scr_mod_extend)
      //show_debug_player("mod_count = "+string(mod_count))
      
      //set the animation variables
      if (anim_extend_start)
      {
        
      // anim_time is used to equate exactly how many frames the animation needs to take
        anim_extend_time = anim_attack_time*0.2 //ceil(room_speed * ((0.01*power(speed_mods,2)) + (0.15*speed_mods) + 1))
        
        // anim_timer is used to equate where the sin/cos wave currently is
        anim_extend_timer = anim_extend_time
        
        pi_time = pi / anim_extend_time
        
        // lastly max_-_multiplier is the maximum distance we want the axis to move, the cos/sin function would move it a parcent of the max
        anim_extend_max_distance_multiplier = 32*(mod_count+1) //2 tiles per mod
        
        // this variable is only used to make sure we only calculate the animation's variables once
        anim_extend_start = false
      }
      
      
      if (mod_count = 0){
        
        ///notes to understand the cos and sin
        // 
        // cos((anim_timer-anim_flip_frame) * pi_time)
        // sin((anim_timer) * pi_time)
        // 
        // anim_timer is used to equate where the wave currently is
        // anim_flip_frame is used to move the wave over, of course if you want to move it over exactly by half then you can just use sin() instead of cos()
        // pi_time is just a method to make the wave it's self. multiplying pi_time will dictate how many times to wave peaks/vallies before it finishes the timer
        // lastly max_-_multiplier is the maximum distance we want the axis to move, the cos/sin function would move it a parcent of the max
        
        
        var trav_dist = (cos((anim_extend_timer) * pi_time)/2+1) * anim_extend_max_distance_multiplier;// + (max_dist_multiplier*0.75);
        
        var x_off = owner_id.x - x;
        var y_off = owner_id.y - y;
        
        x += x_off + lengthdir_x(dis+trav_dist, owner_id.direction);
        y += y_off + lengthdir_y(dis+trav_dist, owner_id.direction);
        
        
        if (anim_extend_timer <= 0)
        {
          anim_extend_start = true
          
          anim_extend_time = 0
          anim_extend_timer = 0
          anim_extend_max_direction_multiplier = 0
          
          return true;
        }
        
        //increment timer
        anim_extend_timer -= 1*lag()//*mod_count
      }
    }else{
      return false;
    }
  }else{
    return false;
  }
//  if (mod_count = 0){
//    mod_extend_start = true;
//  }
  
  return returned
  
//}


