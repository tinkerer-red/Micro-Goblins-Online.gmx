///scr_mod_airStrike
//
//ranged
//proj spawn modifier

//show_debug_message("scr_mod_airStrike")

if (object_index = obj_weapon) && (w_type = weapon_type_range || melee_ranged > 0){
  //show_debug_message("made it inside the effects!")
  
  var mod_count = scr_queue_has_mod_count(active_queue, scr_mod_airStrike)
  var proj_count = ds_queue_size(self.recent_proj_queue)
  
  if !variable_instance_exists(self, "mod_airstrike_start"){
    mod_airstrike_start = true;
    //////////////////////////mod_airstrike_sections_count = w_range/proj_count //even out the number of projectile spacing
    mod_airstrike_timer = (room_speed*2)-((room_speed*2)/5*(mod_count-1))
    mod_airstrike_timer_max = mod_airstrike_timer
    
    is_airstrike = true;
    
    
    //center all projectiles above the player
    while ds_queue_size(self.recent_proj_queue) != 0{
      var _proj = ds_queue_dequeue(self.recent_proj_queue);
      
      _proj.is_airstrike = true;
      
      //collide point
      _proj.mod_airstrike_end_point_x = x + lengthdir_x(_proj.w_range, _proj.direction)
      _proj.mod_airstrike_end_point_y = y + lengthdir_y(_proj.w_range, _proj.direction)
    }
    
    //add the projectiles back into the queue
    ds_queue_copy(self.recent_proj_queue, self.proj_queue)
  
  }
  
  ////////////effect////////////
  if (mod_airstrike_start = true){
    mod_airstrike_start = false;
    
    //increment projectile travel distance for use as a timer
    repeat(ds_queue_size(self.recent_proj_queue)){
      var _proj = ds_queue_dequeue(self.recent_proj_queue);
      
      //make sure the instance wasnt removed from the lag controller
      if instance_exists(_proj){
        ////these two are not needed but im leaving them here for testing to make sure
  //                                                var __proj = ds_queue_dequeue(self.proj_queue);
  //                                                if (_proj != __proj) {show_message("scr_mod_airStrike: _proj != __proj")}
        //////////////////////////
        
        _proj.dis_traveled += _proj.w_range/mod_airstrike_timer_max*lag()
        
        if (_proj.dis_traveled >= _proj.w_range){ //if we have reached our end point
          
          _proj.x = _proj.mod_airstrike_end_point_x
          _proj.y = _proj.mod_airstrike_end_point_y
          //_proj.projectile_active = true
          _proj.is_airstrike = false
          
          
          init_projectile(_proj)
        }else{
          //add the projectiles back into the queue
          ds_queue_enqueue(self.recent_proj_queue, _proj)
          ds_queue_enqueue(self.proj_queue, _proj)
        }
      }
    }
    if (mod_airstrike_timer < 0) || (ds_queue_size(self.recent_proj_queue) = 0){
      //reload the queue
      ds_queue_copy(self.recent_proj_queue, self.proj_queue)
      return true
    }
    
  }
  
  if (mod_count = 1){
    mod_airstrike_start = true;
  }else{ //if we have more then a single mod in the queue remove them, because ideally we never need more then a single mod to handle anything
    return true
  }
  
}else{
  return true;
}
