///scr_mod_summon_movement_default()


//init
if !variable_instance_exists(self.id, "eMovement_event"){
  eMovement_event = ev_step
}

/*   ////This code is reserved here incase Red forgets to initialize create events on their first pass.
if (self.eMovement_event = ev_create) && (self.mods_init = false) {

}
*/


//if we're in the correct event then activate
if (event_type = eMovement_event) {
  
  tile_layer_find(depth, x, y);
  
  
  
  
}

