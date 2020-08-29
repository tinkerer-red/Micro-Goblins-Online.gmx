///scr_mod_inaccurate()
//
//projectile spawn event

//show_debug_message("scr_mod_inaccurate()")

if (w_type = weapon_type_range) || (ranged = true)
{
  var self.temp_queue = ds_queue_create()
  ds_queue_copy(self.temp_queue, self.proj_queue)
  
  while !ds_queue_empty(self.temp_queue)
  {
    with (ds_queue_dequeue(self.temp_queue))
    {
      self.direction += random_range(-18, 18);
    }
  }
  
  ds_queue_destroy(self.temp_queue)
  self.temp_queue = -1
}


return true

