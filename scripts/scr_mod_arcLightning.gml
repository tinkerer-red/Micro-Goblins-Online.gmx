///scr_mod_arcLightning
//
//ranged
//proj spawn modifier

//show_debug_message("scr_mod_arcLightning")

if (object_index = obj_weapon) && (w_type = item_type_weapon_range || melee_ranged > 0){
  
  //we only need to activate this mod a single time, no matter how many instances of the mod there are.
  if !variable_instance_exists(self, "mod_arcLightning_start"){
    
    var mod_count = scr_queue_has_mod_count(active_queue, scr_mod_arcLightning)
    var proj_count = ds_queue_size(self.recent_proj_queue)
    
    mod_arcLightning_start = true;
    
    var max_arcs = (0.5*power(proj_count, 2)) + (0.5*proj_count)
    
    mod_arcLightning_count = ceil((max_arcs/2)+ (((max_arcs/2)/5)*mod_count))
    
    //show_debug_message("max_arcs = "+string(max_arcs))
    //show_debug_message("mod_arcLightning_count = "+string(mod_arcLightning_count))
    
    var temp_queue = ds_queue_create()
    ds_queue_copy(temp_queue, self.recent_proj_queue)
    ds_queue_enqueue(temp_queue, owner_id) //add in the player so projectiles can link with their owner
    
    var _nth = 7
    
    //for every projectile
    repeat (mod_arcLightning_count){
      var _proj = ds_queue_dequeue(self.recent_proj_queue);
      _proj.is_arcLightning = true;
      _proj.arc_frame = 0;
      
      //cycle through the temp queue Nth times
      repeat (_nth){
        var _n = ds_queue_dequeue(temp_queue);
        ds_queue_enqueue(temp_queue, _n)
      }
      
      //make sure it's partner isnt it's self
      if (_proj = _n){
        var _n = ds_queue_dequeue(temp_queue);
        ds_queue_enqueue(temp_queue, _n)
      }
      
      //partner them
      if variable_instance_exists(self, "mod_arcLightning_partner_array"){
        //if the array already exists find out what possition we're on
        var array_slot = array_length_1d(_proj.mod_arcLightning_partner_array);
        _proj.mod_arcLightning_partner_array[array_slot] = _n
      }else{ // else create the array
        _proj.mod_arcLightning_partner_array[0] = _n
      }
      
      //reload the projectile back into the queue
      ds_queue_enqueue(self.recent_proj_queue, _proj)
    }
    //destroy the temp queue to save memory
    ds_queue_destroy(temp_queue)
    
    return true;
    
  }else{///if this isnt the first pass then ignore all other counts of the mod
    return true;
  }
}
  
