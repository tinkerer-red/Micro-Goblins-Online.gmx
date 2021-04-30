///scr_mod_delay
//
//global
//queue_attack_step_mods

//show_debug_message("delay")

var mod_count = scr_queue_has_mod_count(self.step_event_queues_temp, scr_mod_delay)

//init
if !variable_instance_exists(self, "mod_delay_start"){
  mod_delay_start = true;
  
  mod_delay_time = room_speed*(mod_count+1)
  mod_delay_timer = 0
  
  if (object_index = obj_weap_proj){
    mod_delay_proj_speed_mem = speed
    speed = 0
  }
  
  if (object_index = obj_weapon) && (w_type = weapon_type_melee){
    self.owner_id.player_state = e_player_state.move
    mod_delay_melee_anim_attack_timer_mem = anim_attack_time
    //self.owner_id.attack = false
    //self.owner_id.post_attack = true
    
    //remember where it was spawned so it wont leave that location
    mod_delay_melee_loc_x = x
    mod_delay_melee_loc_y = y
    mod_delay_melee_dir = w_start_dir
    mod_delay_melee_image_angle = w_start_dir-45
  }
  
  if (object_index = obj_enemy) || (object_index = obj_summon){
    move_active = true
    attack_active = true
    speed = 0
  }
  
}


if (mod_count = 0) && (mod_delay_start = true){
    mod_delay_timer += 1*lag()
    
    //show_debug_message("mod_delay_timer = "+string(mod_delay_timer))
    
    if (mod_delay_timer >= mod_delay_time){
      if (object_index = obj_weap_proj){
        speed = mod_delay_proj_speed_mem
      }
      
      if (object_index = obj_weapon) && (w_type = weapon_type_melee){
        self.owner_id.player_state = e_player_state.move
        self.owner_id.attack = false
        self.owner_id.post_attack = true
        
        //keep it's possition where it is
        x = mod_delay_melee_loc_x
        y = mod_delay_melee_loc_y
        direction = mod_delay_melee_dir;
        image_angle = mod_delay_melee_image_angle;
        
      }
      
      if (object_index = obj_enemy) || (object_index = obj_summon){
        //show_debug_message("attack_active = "+string(attack_active))
        move_active = false
        attack_active = false
      }
      mod_delay_start = false
      return true
      
    }else{
      if (object_index = obj_weapon) && (w_type = weapon_type_melee){
        anim_attack_timer = anim_attack_time //mod_delay_melee_anim_attack_timer_mem
        
          //keep it's possition where it is
          x = mod_delay_melee_loc_x
          y = mod_delay_melee_loc_y
          direction = mod_delay_melee_dir;
          image_angle = mod_delay_melee_image_angle;
        
      }
      return false;
    }
}else{
  return true
}

return false;
