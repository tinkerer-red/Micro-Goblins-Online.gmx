///scr_mod_continuous
//
//collision modifier

//show_debug_message("scr_mod_continuous")



///define variables on first launch
if !variable_instance_exists(self.id, "continuous_start"){
  self.continuous_start = true
  
  var mod_continuous_mod_count = scr_queue_has_mod_count(active_queue, scr_mod_continuous);
  
  //check for AOE
  var mod_aoe_mod_count = scr_queue_has_mod_count(active_queue, scr_mod_aoe);
  if sign(mod_aoe_mod_count){
    has_aoe = true
  }else{
    has_aoe = false
  }
  
  //massiveley drop the DPS
  w_damage /= (room_speed*0.8)
  
  //continuous timer
  mod_continuous_timer = room_speed*mod_continuous_mod_count
  speed = 0
  
  if not (has_aoe){
  
    if (collide_enemy){
      if instance_exists(collide_enemy){
        if (object_index = obj_weapon)
        || (object_index = obj_weap_proj){
          deal_tick_damage(collide_enemy, w_damage, mod_continuous_timer, owner_id)
        }else{//if it's a player, summon, tile, enemy, boss, etc
          deal_tick_damage(collide_enemy, w_damage, mod_continuous_timer, self)
        }
      }
    }
  
  }
  else //if AOE is in the queue
  {
    return true;
  }
  
}


/*
if self.continuous_start {
  ///for all three types of collision we have different effects,
  
  if (collide_solid){
    //just sit there looking pretty
  }
  if (collide_ground){
    //just sit there looking pretty
  }
  if (collide_enemy){
    
    if instance_exists(collide_enemy){
      //stick to the enemy
      stick_to_angle(collide_enemy, mod_continuous_stick_to_xoff, mod_continuous_stick_to_yoff, mod_continuous_stick_to_angle)
    }
  }
  
  mod_continuous_timer -= 1*lag()
  
  if (mod_continuous_timer <= 0){
    return true;
  }
}

if (object_index != obj_weap_proj) {
  return true;
}
*/
return true;
