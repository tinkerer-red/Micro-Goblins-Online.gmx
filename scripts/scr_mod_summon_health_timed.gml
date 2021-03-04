///scr_mod_summon_health_timed()

if (object_index = obj_summon) || (object_index = obj_enemy){
    //init
    if !variable_instance_exists(self, "mod_summon_health_timed_start"){
      var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_health_timed)+1;
      //show_debug_message("health mod_count = "+string(mod_count))
      health_time_timer = (e_health+mod_count)*room_speed
      health_time_start_time = health_time_timer
      health_time_start_health = e_health
      
      e_health = 9999
      mod_summon_health_timed_start = true;
    }
    
    if (mod_summon_health_timed_start = true){
      /*   //LAWL NEgative health means nothing!!!
      if (e_health <= 0){
        
        //instance_destroy(self)
        //return true;
      }
      */
      
      if (health_time_timer > 0){
        health_time_timer -= 1*lag()
        e_health = lerp(0, health_time_start_health, (health_time_timer/health_time_start_time))
        show_debug_player(0, "health_time_timer = "+string(health_time_timer))
      }else{
        instance_destroy(self)
        return true;
      }
    }
}

return false
