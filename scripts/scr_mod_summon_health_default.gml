///scr_mod_summon_health_default()

//init
if !variable_instance_exists(self.id, "eHealth_event"){
  eHealth_event = ev_create
  
}

/*   ////This code is reserved here incase Red forgets to initialize create events on their first pass.
if (self.eHealth_event = ev_create) && (self.mods_init = false) {

}
*/

