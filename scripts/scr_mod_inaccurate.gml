///scr_mod_inaccurate()
//
//projectile spawn event

//show_debug_message("scr_mod_inaccurate()")

if !to_much_lag(){
  
  if (w_type = item_type_weapon_range) || (melee_ranged > 0)
  {
    var temp_queue = ds_queue_create()
    ds_queue_copy(temp_queue, self.proj_queue)
    
    while !ds_queue_empty(temp_queue)
    {
      var proj = ds_queue_dequeue(temp_queue);
      //original offset
      //orig_dir  = proj.direction
      orig_dist = point_distance(proj.x, proj.y, owner_id.x, owner_id.y)
      
      proj.direction += htme_random_range(-18, 18);
      proj.w_range += htme_random_range(-64, 64)
      proj.dis_traveled += htme_random_range(-2, 2) //the -2 is there for use with air_strike, any other time it wont be noticed
      
      //new offset
      proj.x = owner_id.x+lengthdir_x(orig_dist, proj.direction)
      proj.y = owner_id.y+lengthdir_y(orig_dist, proj.direction)
    }
    
    ds_queue_destroy(temp_queue)
    temp_queue = -1
  }
  
}  
return true

