///scr_mod_flail
//
//melee
//weap step modifier

if (object_index = obj_weapon) && (w_type = item_type_weapon_melee){
  
  if !variable_instance_exists(self, "mod_flail_start"){
    mod_flail_start = true;
  }
  
  var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_flail)
  
  //show_debug_message("flail")
  if (owner_id.item_a || owner_id.item_b || owner_id.item_c){
    
    if (mod_flail_start = true){
      mod_flail_start = false;
      
      //prevent the timer from counting down past 0
      if (anim_attack_timer <= (1*lag())){
        anim_attack_timer += 1*lag()
      }
      
      //move the attack into the direction the player is currently pressing
      if not ((!ceil(owner_id.right) && !ceil(owner_id.left) && !ceil(owner_id.down) && !ceil(owner_id.up)) || 
      (owner_id.right == owner_id.left && owner_id.up == owner_id.down)){
        
        var flail_angle_change = (180/room_speed)*(mod_count+1);
      
        var ideal_dir = point_direction(0, 0, owner_id.right-owner_id.left, owner_id.down-owner_id.up);
        var angle_diff = angle_difference(w_start_dir, ideal_dir);
        
        //smooth angle change for flail
        if (abs(angle_diff) > flail_angle_change){
          direction -= (sign(angle_diff) * flail_angle_change)// * lag()
          w_start_dir  -= (sign(angle_diff) * flail_angle_change)// * lag()
          image_angle = direction-45
        }else{
          direction -= angle_diff
          w_start_dir -= angle_diff
          image_angle = direction-45
        }
        
        //adjust possition
        //x += lengthdir_x(dis, direction);
        //y += lengthdir_y(dis, direction);
        
      }
    }
    
  }else{
    return true
  }
  
  if (mod_count = 0){
    mod_flail_start = true;
  }
}else{
  return true;
}
