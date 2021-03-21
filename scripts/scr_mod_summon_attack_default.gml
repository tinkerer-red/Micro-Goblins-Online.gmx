///scr_mod_summon_attack_default()

if (object_index = obj_summon) || (object_index = obj_enemy){
    //init
    if !variable_instance_exists(self, "mod_summon_attack_default_start"){
      var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_attack_default)+1;
      //show_debug_message("attack mod_count = "+string(mod_count))
    
      e_damage += 0.5*mod_count
      
      mod_summon_attack_default_start = true
    }
    
    
    /*   ////This code is reserved here incase Red forgets to initialize create events on their first pass.
    // thanks past red!
    //// thanks past red again! 2/10/21
    if (self.eAttack_event = ev_create) && (self.mods_init = false) {
    
    }
    */
    
    if (move_active = false){ //if we arew not restrained by movement mods
      //if we're in the correct event then activate
      if (mod_summon_attack_default_start = true) {
        if (enemy != noone) {
          if place_meeting(x, y, enemy) {
            deal_damage(enemy, e_damage)
          }
        }
      }
    }
}

return false;



