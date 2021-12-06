///scr_mod_flail

/* This script is used to animate the melee weapon for a flail
     attack.
   
   Make sure to account for player direction as the sprite will
     rotate in different styles based on the direction it rotated
     to.
   
   Returns: Bool (True when animation is finished, False for any other state)
*/


var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_flail)


if (object_index = obj_weapon) && (w_type = item_type_weapon_melee){
  returned = false
  
  
  //set the animation variables
  if !variable_instance_exists(self.id, "anim_flail_start"){
    mod_flail_count = mod_count+1
    
    anim_attack_timer += (room_speed*0.2)*mod_flail_count
    
    // anim_time is used to equate exactly how many frames the animation needs to take
    anim_flail_time = anim_attack_timer //ceil(room_speed * ((0.01*power(speed_mods,2)) + (0.15*speed_mods) + 1))
    
    // anim_timer is used to equate where the sin/cos wave currently is
    anim_flail_timer = 0
    
    // this variable is only used to make sure we only calculate the animation's variables once
    anim_flail_start = false
    
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
  
  if (mod_count = 0){
//    mod_flail_start = false;
    
    //define the flails current reach, this is used to lurch the weapon forward at the begining
    var trav_dist = tanh(((anim_flail_timer*2)/anim_flail_time)*pi) * point_distance(owner_id.x, owner_id.y, x, y)
    
    /// a negative number means we were facing right, and we're turning left
    var trav_dir = (anim_flail_timer/anim_flail_time)*360
    
    //we invert this number just to make the player left handed
    var trav_dir = w_start_dir+(trav_dir * -1);
    
    var x_off = owner_id.x - x;
    var y_off = owner_id.y - y;
    
    x += x_off + lengthdir_x(trav_dist, direction+trav_dir);
    y += y_off + lengthdir_y(trav_dist, direction+trav_dir);
    
    direction = point_direction(owner_id.x, owner_id.y, x, y)
    image_angle = direction-45
    
    
    if (anim_flail_timer >= anim_flail_time*(mod_flail_count+1)){
      returned = true
      
      anim_flail_start = true
      
      anim_flail_time = 0
      anim_flail_timer = 0
      anim_flail_max_direction_multiplier = 0
    }
  
  
    //increment timer
    anim_flail_timer += mod_flail_count*lag() //*mod_count
  }
  
//  if (mod_count = 0){
//    mod_flail_start = true;
//  }

  return returned
  
}else{ //if not melee or weapon
  return true
}



  
