///scr_mod_summon_movement_default()


//init
if !variable_instance_exists(self.id, "eMovement_event"){
  eMovement_event = ev_step
  
  mp_maxrot   = 45   //The number of degrees either side of the current direction that the instance can rotate in a step 
  mp_rotstep  = 22.5  //The number of degrees either side of the current direction that the instance can check for a collision
  mp_ahead    = 0  //The number of steps ahead that the instance can check for a collision. Larger values are slower than lower ones.
  mp_onspot   = true  //Use this to allow the instance to rotate on the spot when no path is found (true) or not (false)
  mp_xgoal    = instance_nearest(x,y,obj_player).x  //The target x position.
  mp_ygoal    = instance_nearest(x,y,obj_player).y  //The target y position.
  mp_stepsize = 2.2  //The speed the instance moves in pixels per step.
  mp_checkall = false  //Whether to check all instances (true) or just solid ones (false).
}

/*   ////This code is reserved here incase Red forgets to initialize create events on their first pass.
if (self.eMovement_event = ev_create) && (self.mods_init = false) {

}
*/


//if we're in the correct event then activate
if (event_type = eMovement_event) {
  //tile_layer_find(depth, x, y);
  mp_potential_settings(mp_maxrot, mp_rotstep, mp_ahead, mp_onspot)
  mp_potential_step(mp_xgoal, mp_ygoal, mp_stepsize, mp_checkall)
  
  mp_xgoal    = instance_nearest(x,y,obj_player).x  //The target x position.
  mp_ygoal    = instance_nearest(x,y,obj_player).y  //The target y position.
}



