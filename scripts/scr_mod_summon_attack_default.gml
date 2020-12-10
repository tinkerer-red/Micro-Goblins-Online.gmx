///scr_mod_summon_attack_default()

//init
if !variable_instance_exists(self, "mod_summon_attack_default_start"){
  var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_attack_default)+1;
  //show_debug_message("attack mod_count = "+string(mod_count))

  e_damage += 0.5*mod_count
  
  mod_summon_attack_default_start = true
}


/*   ////This code is reserved here incase Red forgets to initialize create events on their first pass.
// thanks past red!
if (self.eAttack_event = ev_create) && (self.mods_init = false) {

}
*/


//if we're in the correct event then activate
if (mod_summon_attack_default_start = true) {
  if (enemy != noone) {
    if place_meeting(x, y, enemy) {
      deal_damage(enemy)
    }
  }
}

return false;



