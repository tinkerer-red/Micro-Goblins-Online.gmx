///scr_mod_summon_health_stout()

if (object_index = obj_summon) || (object_index = obj_enemy){
    //init
    if !variable_instance_exists(self, "mod_summon_health_stout_start"){
      var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_health_stout)+1;
      //show_debug_message("health mod_count = "+string(mod_count))
      mod_summon_health_stout_start = true;
      
      stout_damage_max = 40 // maybe?
      stout_damage_min = 1 // maybe?
      
      stout_size_max = 3 // maybe?
      stout_size_min = 0.25 // maybe?
      
      stout_health_max = 150
    }
    
    if (mod_summon_health_stout_start = true){
      e_damage = lerp(stout_damage_min, stout_damage_max, (e_health/stout_health_max))
      var _scale = lerp(stout_size_min, stout_size_max, (e_health/stout_health_max))
      image_xscale = _scale
      image_yscale = _scale
    }
}

return false
