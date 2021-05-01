///scr_mod_summon_movement_jumpy()


///scr_mod_summon_movement_jumpy()
//
//summon step event

if (object_index = obj_summon) || (object_index = obj_enemy){
    
    
    //init
    if !variable_instance_exists(self, "mod_summon_movement_jumpy_start"){
      
      mod_summon_movement_jumpy_mod_count = scr_queue_has_mod_count(step_event_queues, scr_mod_summon_movement_jumpy)
      
      //stat buffs
      e_damage += 0.25*mod_summon_movement_jumpy_mod_count
      
      if is_summoned{
        dir = point_direction(owner_id.x, owner_id.y, x, y)
      }else{
        dir = 0
      }
      
      //center x and y
      mod_jumpy_cx = x
      mod_jumpy_cy = y
      
      //previous location init
      pre_x = start_x
      pre_y = start_y
      
      //ideal direction before input manipulation
      mod_jumpy_ideal_speed = 0
      mod_jumpy_ideal_direction = 0
      
      //ideal vector
      mod_jumpy_vector_x = 0
      mod_jumpy_vector_y = 0
      
      //max movement
      mod_jumpy_dist_max = sprite_width*((mod_summon_movement_jumpy_mod_count + (is_summoned*0.25))*3 + 1)
      mod_jumpy_move_time = room_speed/mod_summon_movement_jumpy_mod_count
      
      mod_summon_movement_jumpy_start = true
    
    } // end of init
    
    
    //if wandering
    if (attack_active = false){ //if we arew not restrained by attack mods
      
      //if summoned update center x,y
      if (is_summoned){
        //center x and y
        mod_jumpy_cx = owner_id.x
        mod_jumpy_cy = owner_id.y
      }
      
      //for the first mod in the queue keep track of the center x and y
      if (mod_summon_movement_jumpy_start = true){
        mod_jumpy_desired_dir  = htme_random_range(0,360)
        mod_jumpy_desired_dist = htme_random_range(0,mod_jumpy_dist_max/5)
        
        //if it's to far from it's central location, move it back
        if (point_distance(x, y, mod_jumpy_cx, mod_jumpy_cy) > mod_jumpy_dist_max){
          var array = add_vectors(mod_jumpy_desired_dist,
                                  mod_jumpy_desired_dir,
                                  point_distance(x, y, mod_jumpy_cx, mod_jumpy_cy),
                                  point_direction(x, y, mod_jumpy_cx, mod_jumpy_cy));
          //then do it again to really convince the entity this is the correct direction.
          var array = add_vectors(array[0],
                                  array[1],
                                  point_distance(x, y, mod_jumpy_cx, mod_jumpy_cy),
                                  point_direction(x, y, mod_jumpy_cx, mod_jumpy_cy));
          mod_jumpy_desired_dist =  array[0]
          mod_jumpy_desired_dir = array[1]
        }
        
        mod_jumpy_desired_x = mod_jumpy_cx+lengthdir_x(mod_jumpy_desired_dist, mod_jumpy_desired_dir)
        mod_jumpy_desired_y = mod_jumpy_cy+lengthdir_y(mod_jumpy_desired_dist, mod_jumpy_desired_dir)
        
        
        //up to five hops per second 
        mod_jumpy_move_timer = mod_jumpy_move_time
        mod_jumpy_hop_count = mod_summon_movement_jumpy_mod_count
        
        mod_summon_movement_jumpy_start = false
      }
      
      
      //keep track of the mod count
      var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_movement_jumpy)+1;
      
      //reload the modifier
      //  this section is only here so we dont have to run the same mod 5 times but just
      //  once with the same calculations and just multiply the result by the mod count.
      if (mod_count = 1){
        //if it's time to decrement the hop
        if (mod_jumpy_move_timer <= 0){
          mod_jumpy_hop_count--;
          mod_jumpy_move_timer = mod_jumpy_move_time
          
          if (mod_jumpy_hop_count <= 0){
            mod_summon_movement_jumpy_start = true;
          }
          
        }else{
          
          //do the jump
          //var movement_speed = point_distance(x, y, mod_jumpy_desired_x, mod_jumpy_desired_y);
          
          //if it's close enough to it's new location, just stop it from moving any more
          if (point_distance(x, y, mod_jumpy_desired_x, mod_jumpy_desired_y) <= 16){
            mod_jumpy_ideal_speed = 0
            mod_jumpy_ideal_direction = 0
          
          }else{ //if we're still fairly far from our desired location lets calculate the movement vector
            
            mod_jumpy_ideal_speed = mod_jumpy_desired_dist
            mod_jumpy_ideal_direction = mod_jumpy_desired_dir
            
          }
          
          mod_jumpy_move_timer -= 1*lag()
        }
      }
      
      var sectioned_direction = section_percent(mod_jumpy_ideal_direction/360, 8)*360
      
      mod_jumpy_vector_x = lengthdir_x(mod_jumpy_ideal_speed, sectioned_direction)
      mod_jumpy_vector_y = lengthdir_y(mod_jumpy_ideal_speed, sectioned_direction)
      
      if (is_summoned){
        //this if statement is only to make sure the summon always stays close to the player, at default view distance
        var distance_to_player = point_distance(x, y, owner_id.x, owner_id.y)
        if (distance_to_player <= 9*16){
          var direction_to_player = point_distance(x, y, owner_id.x, owner_id.y);
          mod_jumpy_vector_x += lengthdir_x(distance_to_player, direction_to_player)
          mod_jumpy_vector_y += lengthdir_y(distance_to_player, direction_to_player)
        }
        mod_jumpy_vector_x += lengthdir_x(owner_id.spd, owner_id.dir)
        mod_jumpy_vector_y += lengthdir_y(owner_id.spd, owner_id.dir)
      }
      
      
      //manipulate it with a cos to make it appear to be momentum base with the hop, so it slows down as it reaches it's final hop
      //we'll use this variable to adjust the inputs
      var hop_multiplier = clamp(cos((mod_jumpy_move_timer/mod_jumpy_move_time)*pi*2) + 0.5, 0, 1);
      
      vector_to_inputs(mod_jumpy_vector_x, mod_jumpy_vector_y, (hop_multiplier*0.75)+ (0.25/(6-mod_jumpy_hop_count)))
      
    }
}

return false;



//if we're in the correct event then activate



