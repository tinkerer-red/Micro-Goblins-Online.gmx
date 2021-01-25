///scr_mod_quickScope()
//
//projectile spawn event

//show_debug_message("scr_mod_quickScope()")

if (w_type = weapon_type_range) || (melee_ranged > 0)
{
  //this is for the weapon, because the projectile init happens after spawn mods
  self.proj_speed += (6*16)/room_speed
  self.w_range += (6*16)
  
  var temp_queue = ds_queue_create()
  ds_queue_copy(temp_queue, self.proj_queue)
  
  while !ds_queue_empty(temp_queue)
  {
    var proj = ds_queue_dequeue(temp_queue);
    proj.speed += (6*16)/room_speed //add a speed of 6 tiles per second to the over all speed
    proj.w_range += (6*16) //add a speed of 6 tiles per second to the over all speed
    
    
  }
  
  ds_queue_destroy(temp_queue)
  temp_queue = -1
}


return true

