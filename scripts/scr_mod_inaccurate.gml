///scr_mod_inaccurate()
//
//projectile spawn event

//show_debug_message("scr_mod_inaccurate()")

if (w_type = weapon_type_range) || (melee_ranged > 0)
{
  var temp_queue = ds_queue_create()
  ds_queue_copy(temp_queue, self.proj_queue)
  
  while !ds_queue_empty(temp_queue)
  {
    var proj = ds_queue_dequeue(temp_queue);
    proj.direction += htme_random_range(-18, 18);
    proj.w_range += htme_random_range(-8, 8)
    proj.dis_traveled += htme_random_range(-2, 2) //the -2 is there for use with air_strike, any other time it wont be noticed
    
  }
  
  ds_queue_destroy(temp_queue)
  temp_queue = -1
}


return true

