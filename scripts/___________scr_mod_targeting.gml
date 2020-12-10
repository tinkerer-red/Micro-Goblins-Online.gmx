///scr_mod_targeting
//
//ranged
//button modifier

if (object_index = obj_weap_proj){
  
  var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_guiding)
  
  if !variable_instance_exists(self, "mod_guiding_start"){
    mod_guiding_start = true;
    mod_guiding_end = false;
    mod_guiding_timer = room_speed*(mod_count+1)
  }
  
  //show_debug_message("guiding")
  
  if (owner_id.item_a || owner_id.item_b || owner_id.item_c)
  && (mod_guiding_timer > 0)
  && (mod_guiding_end = false){
    
    
    if (mod_guiding_start = true){
      mod_guiding_start = false;
      
      mod_guiding_timer -= 1*lag()
      
    //prevent the timer from counting down past 0
      if instance_exists(owner_weap){
        if (owner_weap.anim_attack_timer <= (3*lag())){
          owner_weap.anim_attack_timer += 1*lag()
        }
      }
      dis_traveled = (abs(mod_guiding_timer - (room_speed*(mod_count+1))) / (room_speed*(mod_count+1))) * w_range
      
      
      //move the attack into the direction the player is currently pressing
      if not ((!ceil(owner_id.right) && !ceil(owner_id.left) && !ceil(owner_id.down) && !ceil(owner_id.up)) || 
      (owner_id.right == owner_id.left && owner_id.up == owner_id.down)){
        
        var guiding_angle_change = (180/room_speed)*(mod_count+1);
        
        var ideal_dir = point_direction(0, 0, owner_id.right-owner_id.left, owner_id.down-owner_id.up);
        var angle_diff = angle_difference(direction, ideal_dir);
        
        //smooth angle change for guiding
        if (abs(angle_diff) > guiding_angle_change){
          direction -= (sign(angle_diff) * guiding_angle_change)// * lag()
          image_angle = direction-45
        }else{
          direction -= angle_diff
          image_angle = direction-45
        }
        
        //adjust possition
        //x += lengthdir_x(dis, direction);
        //y += lengthdir_y(dis, direction);
        
      }
    }
  
  }else{
    mod_guiding_end = true;
    return true
  }
  
  if (mod_count = 0){
    mod_guiding_start = true;
  }
}else{
  return true;
}
