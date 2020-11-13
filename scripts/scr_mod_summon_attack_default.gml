///scr_mod_summon_attack_default()

//init
if !variable_instance_exists(self.id, "eAttack_event"){
  eAttack_event = ev_step
  
  attack_damage = 0.5
}


/*   ////This code is reserved here incase Red forgets to initialize create events on their first pass.
if (self.eAttack_event = ev_create) && (self.mods_init = false) {

}
*/


//if we're in the correct event then activate
if (event_type = eMovement_event) {
  if col_with_player(){
    deal_damage(instance_nearest(x, y, obj_player))
  }
}




