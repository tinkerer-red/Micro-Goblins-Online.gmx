///scr_mod_summon_movement_default()


///scr_mod_summon_movement_default()
//
//summon step event

if (object_index = obj_summon) || (object_index = obj_enemy){
    
    //init
    if !variable_instance_exists(self, "mod_summon_movement_default_start"){
      mod_summon_movement_default_wander_timer = 0
      
      mp_xgoal = start_x;
      mp_ygoal = start_y;
      
      if (enemy != noone){
        mp_xgoal    = enemy.x;  //The target x position.
        mp_ygoal    = enemy.y;  //The target y position.
      }else{
        mod_summon_movement_default_wander_timer = room_speed
//        var mp_xgoal    = start_x  //The target x position.
//        var mp_ygoal    = start_y  //The target y position.
      }
      mod_summon_movement_default_mod_count = scr_queue_has_mod_count(step_event_queues, scr_mod_summon_movement_default)
      max_step_size = 0.25 + mod_summon_movement_default_mod_count * 0.15
      
      mod_summon_movement_default_start = true
    }
    
    var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_movement_default)+1
    
    if (attack_active = false){ //if we arew not restrained by attack mods
      if (mod_summon_movement_default_start = true){
        
        mod_summon_movement_default_start = false
        
        //varify enemy
        if (enemy != noone)
        && instance_exists(enemy){
        
          // move to enemy
          mp_xgoal = enemy.x;
          mp_ygoal = enemy.y;
          
          //set wander timer to 0 so a new location is generated when the enemy is out of range
            mod_summon_movement_default_wander_timer = room_speed
        }else{
          if (is_summoned)
          && (point_distance(x, y, owner_id.x, owner_id.y) > 16*8)
          {
            mp_xgoal = owner_id.x;
            mp_ygoal = owner_id.y;
          }else{
            if (is_summoned){
              start_x = owner_id.x
              start_y = owner_id.y
            }
            //if still wandering decrement timer
            mod_summon_movement_default_wander_timer -= 1*lag()
            
            if (mod_summon_movement_default_wander_timer <= 0){
              //wander
              mp_xgoal = start_x+htme_random(16*8);
              mp_ygoal = start_y+htme_random(16*8);
              //reset wander timer
              mod_summon_movement_default_wander_timer = room_speed
            }
          }
        }
          var xx = mp_xgoal - x;
          var yy = mp_ygoal - y;
          
          //actually apply the inputs
          up += abs(sign(min(yy, 0))*max_step_size)
          down += sign(max(yy, 0))*max_step_size
          left += abs(sign(min(xx, 0))*max_step_size)
          right += sign(max(xx, 0))*max_step_size
          
          update_enemy(room_speed*3)
        }
      }
    
    if (mod_count = 1){
      mod_summon_movement_default_start = true
    }
}
    
return false;



