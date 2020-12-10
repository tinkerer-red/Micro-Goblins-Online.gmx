///scr_mod_summon_movement_default()


///scr_mod_seeking()
//
//projectile step event

//show_debug_message("scr_mod_seeking()")


//init
if !variable_instance_exists(self, "mod_summon_movement_default_start"){
  mp_maxrot   = 45   //The number of degrees either side of the current direction that the instance can rotate in a step 
  mp_rotstep  = 22.5  //The number of degrees either side of the current direction that the instance can check for a collision
  mp_ahead    = 0  //The number of steps ahead that the instance can check for a collision. Larger values are slower than lower ones.
  mp_onspot   = true  //Use this to allow the instance to rotate on the spot when no path is found (true) or not (false)
  
  if (enemy != noone){
    mp_xgoal    = enemy.x  //The target x position.
    mp_ygoal    = enemy.y  //The target y position.
  }else{
    mp_xgoal    = x  //The target x position.
    mp_ygoal    = y  //The target y position.
  }
  var max_step_size = 2.2
  mp_stepsize = max_step_size*0.2  //The speed the instance moves in pixels per step.
  mp_checkall = false  //Whether to check all instances (true) or just solid ones (false).
  
  mod_summon_movement_default_start = true
}





var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_movement_default)+1


if (mod_summon_movement_default_start = true){
  mod_summon_movement_default_start = false
  
  if (enemy != noone){
    //tile_layer_find(depth, x, y);
    mp_potential_settings(mp_maxrot, mp_rotstep, mp_ahead, mp_onspot)
    mp_potential_step(mp_xgoal, mp_ygoal, mp_stepsize*mod_count, mp_checkall)
    
    
    ///only update once every 3 seconds
    if (update_enemy_time >= room_speed*3){
      enemy = nearest_enemy(x,y, 16*50)
      update_enemy_time = 0
    }else{
      update_enemy_time += 1*lag()
    }
    
    mp_xgoal    = enemy.x  //The target x position.
    mp_ygoal    = enemy.y  //The target y position.
    
  }else{ //if no enemy is defined wander
    //wander code goes here
    mp_potential_settings(mp_maxrot, mp_rotstep, mp_ahead, mp_onspot)
    mp_potential_step(x+1, y+1, mp_stepsize/3, mp_checkall)
  }
  
}



//reload the modifier
//  this section is only here so we dont have to run the same mod 5 times but just
//  once with the same calculations and just multiply the result by 5.
if (mod_count = 1){
  mod_summon_movement_default_start = true;
}

return false;



//if we're in the correct event then activate



