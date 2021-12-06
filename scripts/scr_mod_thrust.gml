///scr_mod_thrust

/* This script is used to animate the melee weapon for a thrust
     attack.
   
   Make sure to account for player direction as the sprite will
     rotate in different styles based on the direction it rotated
     to.
   
   Returns: Bool (True when animation is finished, False for any other state)
*/
//if !variable_instance_exists(self, "mod_thrust_start"){
//  mod_thrust_start = true;
//}

//var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_thrust)

//if (mod_thrust_start = true){
//  mod_thrust_start = false;
  
  if (object_index = obj_weapon) && (w_type = item_type_weapon_melee){
    returned = false
    
    
    if !variable_instance_exists(self.id, "anim_thrust_start") {anim_thrust_start = true}
    
    
    //set the animation variables
    if (anim_thrust_start)
    {
      
    // anim_time is used to equate exactly how many frames the animation needs to take
      anim_thrust_time = anim_attack_time //ceil(room_speed * ((0.01*power(speed_mods,2)) + (0.15*speed_mods) + 1))
      
      // anim_timer is used to equate where the sin/cos wave currently is
      anim_thrust_timer = anim_thrust_time
      
      pi_time = pi / anim_thrust_time
      
      // lastly max_-_multiplier is the maximum distance we want the axis to move, the cos/sin function would move it a parcent of the max
      anim_thrust_max_direction_multiplier = 180
      
      // this variable is only used to make sure we only calculate the animation's variables once
      anim_thrust_start = false
      
      max_dist_multiplier = dis*0.75
      max_dir_multiplier = 20
      
    }
    
    
    ///notes to understand the cos and sin
    // 
    // cos((anim_timer-anim_flip_frame) * pi_time)
    // sin((anim_timer) * pi_time)
    // 
    // anim_timer is used to equate where the wave currently is
    // anim_flip_frame is used to move the wave over, of course if you want to move it over exactly by half then you can just use sin() instead of cos()
    // pi_time is just a method to make the wave it's self. multiplying pi_time will dictate how many times to wave peaks/vallies before it finishes the timer
    // lastly max_-_multiplier is the maximum distance we want the axis to move, the cos/sin function would move it a parcent of the max
    
    
    /// a negative number means we were facing right, and we're turning left
    var trav_dist = cos((anim_thrust_timer) * pi_time*(60/6)) * max_dist_multiplier;// + (max_dist_multiplier*0.75);
    var trav_dir = cos((anim_thrust_timer) * pi_time*(80/6)) * max_dir_multiplier;
    
    var x_off = owner_id.x - x;
    var y_off = owner_id.y - y;
    
    x += x_off + lengthdir_x(dis+trav_dist, direction+trav_dir);
    y += y_off + lengthdir_y(dis+trav_dist, direction+trav_dir);
    
    direction = point_direction(owner_id.x, owner_id.y, x, y)
    image_angle = direction-45
    
    if (anim_thrust_timer <= 0)
    {
      returned = true
      anim_thrust_start = true
      
      anim_thrust_time = 0
      anim_thrust_timer = 0
      anim_thrust_max_direction_multiplier = 0
    }
    
    //increment timer
    anim_thrust_timer -= 1*lag()//*mod_count
  }else{
    return true;
  }
  
//  if (mod_count = 0){
//    mod_thrust_start = true;
//  }
  
  return returned
  
//}


