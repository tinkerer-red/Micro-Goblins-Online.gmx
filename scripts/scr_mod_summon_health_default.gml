///scr_mod_summon_health_default()

if (object_index = obj_summon) || (object_index = obj_enemy){
    //init
    if !variable_instance_exists(self, "mod_summon_health_default_start"){
      var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_health_default)+1;
      //show_debug_message("health mod_count = "+string(mod_count))
      e_health += 5*mod_count
      mod_summon_health_default_start = true;
    }
    
    if (e_health <= 0){
      instance_destroy(self)
      return true
    }
}

return false
