///scr_mod_moveable
//
//global
//queue_attack_step_mods

//show_debug_message("moveable")

if (object_index = obj_weapon) && (w_type = item_type_weapon_melee){

var mod_count = scr_queue_has_mod_count(self.step_event_queues_temp, scr_mod_moveable)

//init
if !variable_instance_exists(self, "mod_moveable_start"){
  mod_moveable_start = true;
  mod_moveable_mod_count = mod_count
  
  mod_moveable_time = room_speed*(mod_count+1)
  mod_moveable_timer = 0
  
  if (object_index = obj_weapon) && (w_type = item_type_weapon_melee){
    self.owner_id.player_state = e_player_state.move
//    mod_moveable_melee_anim_attack_timer_mem = anim_attack_time
    //self.owner_id.attack = false
    //self.owner_id.post_attack = true
  }
}


if (mod_count = 0) && (mod_moveable_start = true){
    mod_moveable_timer += 1*lag()
    self.owner_id.player_state = e_player_state.move
//    if (mod_moveable_timer >= mod_moveable_time){
//      
//        self.owner_id.player_state = e_player_state.move
//        self.owner_id.attack = false
//        self.owner_id.post_attack = true
//      
//      mod_moveable_start = false
//      return true
//      
//    }else{
//      anim_attack_timer = anim_attack_time //mod_moveable_melee_anim_attack_timer_mem
      
      //move the attack into the direction the player is currently pressing
      if not ((!ceil(owner_id.right) && !ceil(owner_id.left) && !ceil(owner_id.down) && !ceil(owner_id.up)) || 
      (owner_id.right == owner_id.left && owner_id.up == owner_id.down)){
        
        var moveable_angle_change = (180/room_speed)*(mod_moveable_mod_count+1);
      
        var ideal_dir = point_direction(0, 0, owner_id.right-owner_id.left, owner_id.down-owner_id.up);
        var angle_diff = angle_difference(w_start_dir, ideal_dir);
        
        //smooth angle change for flail/moveable angle
        if (abs(angle_diff) > moveable_angle_change){
          direction -= (sign(angle_diff) * moveable_angle_change)// * lag()
          w_start_dir  -= (sign(angle_diff) * moveable_angle_change)// * lag()
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
      
      return false;
//    }
}else{
  return true
}
}
return true;



