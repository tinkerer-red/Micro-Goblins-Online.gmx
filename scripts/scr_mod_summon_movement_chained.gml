///scr_mod_summon_movement_chained()


///scr_mod_summon_movement_chained()
//
//summon step event

if (object_index = obj_summon) || (object_index = obj_enemy){
    
    
    //init
    if !variable_instance_exists(self, "mod_summon_movement_chained_start"){
      
      mod_summon_movement_chained_mod_count = scr_queue_has_mod_count(step_event_queues, scr_mod_summon_movement_chained)
      
      //stat buffs
      e_damage += 0.25*mod_summon_movement_chained_mod_count
      
      if is_summoned{
        dir = point_direction(owner_id.x, owner_id.y, x, y)
      }else{
        dir = 0
      }
      
      //center x and y
      mod_chained_cx = x
      mod_chained_cy = y
      
      //previous location init
      pre_x = start_x
      pre_y = start_y
      
      //ideal direction before input manipulation
      mod_chained_ideal_speed = 0
      mod_chained_ideal_direction = 0
      
      //ideal vector
      mod_chained_vector_x = 0
      mod_chained_vector_y = 0
      
      //max movement
      mod_chained_dist_max = sprite_width*((mod_summon_movement_chained_mod_count + (is_summoned*0.5))*4 + 1)
      mod_chained_move_time = room_speed/mod_summon_movement_chained_mod_count
      
      mod_summon_movement_chained_start = true
    }
    
    if (attack_active = false){ //if we arew not restrained by attack mods
      
      //for the first mod in the queue keep track of the center x and y
      if (mod_summon_movement_chained_start = true){
        var mod_chained_desired_dir  = htme_random_range(0,360)
        var mod_chained_desired_dist = htme_random_range(0,mod_chained_dist_max/2.5)
        
        mod_chained_desired_x = mod_chained_cx+lengthdir_x(mod_chained_desired_dist, mod_chained_desired_dir)
        mod_chained_desired_y = mod_chained_cy+lengthdir_y(mod_chained_desired_dist, mod_chained_desired_dir)
        
        //up to five hops per second 
        mod_chained_move_timer = mod_chained_move_time
        mod_chained_hop_count = mod_summon_movement_chained_mod_count
        
        mod_summon_movement_chained_start = false
      
      } //end init
      
      
      //keep track of the mod count
      var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_movement_chained)+1;
      
      //reload the modifier
      //  this section is only here so we dont have to run the same mod 5 times but just
      //  once with the same calculations and just multiply the result by the mod count.
      if (mod_count = 1){
        
        //if summoned update center x,y
        if (is_summoned){
          //center x and y
          mod_chained_cx = owner_id.x
          mod_chained_cy = owner_id.y
        }
        
        //move the entity back to it's starting location if it's out of bounds
        if (point_distance(mod_chained_cx, mod_chained_cy, x, y,) >= mod_chained_dist_max){
          var array = add_vectors(mod_chained_ideal_speed, 
                                  mod_chained_ideal_direction, 
                                  point_distance(x, y, mod_chained_cx, mod_chained_cy),
                                  point_direction(x, y, mod_chained_cx, mod_chained_cy));
          mod_chained_ideal_speed =  array[0]
          mod_chained_ideal_direction = array[1]
          
          vector_to_inputs(mod_chained_vector_x, mod_chained_vector_y, 2)
        }

        //if it's time to decrement the hop
        if (mod_chained_move_timer <= 0){
          mod_chained_hop_count--;
          mod_chained_move_timer = mod_chained_move_time
          
          if (mod_chained_hop_count <= 0){
            mod_summon_movement_chained_start = true;
          }
          
        }else{
          
          //do the jump
          var movement_speed = point_distance(x, y, mod_chained_desired_x, mod_chained_desired_y);
          
          //if it's close enough to it's new location, just stop it from moving any more
          if (point_distance(x, y, mod_chained_desired_x, mod_chained_desired_y) <= 16){
            mod_chained_ideal_speed = 0
            mod_chained_ideal_direction = 0
          
          }else{ //if we're still fairly far from our desired location lets calculate the movement vector
            
            mod_chained_ideal_speed = point_distance(x, y, mod_chained_desired_x, mod_chained_desired_y)
            mod_chained_ideal_direction = point_direction(x, y, mod_chained_desired_x, mod_chained_desired_y)
            
            
            //if it's to far from it's central location, move it back
            if (point_distance(x, y, mod_chained_cx, mod_chained_cy) > mod_chained_dist_max){
              var array = add_vectors(mod_chained_ideal_speed,
                                      mod_chained_ideal_direction,
                                      point_distance(x, y, mod_chained_cx, mod_chained_cy),
                                      point_direction(x, y, mod_chained_cx, mod_chained_cy));
              mod_chained_ideal_speed =  array[0]
              mod_chained_ideal_direction = array[1]
            }
          
          }
          
          mod_chained_move_timer -= 1*lag()
        }
      }
      
      mod_chained_vector_x = lengthdir_x(mod_chained_ideal_speed, mod_chained_ideal_direction)
      mod_chained_vector_y = lengthdir_y(mod_chained_ideal_speed, mod_chained_ideal_direction)
      
      
      //manipulate it with a cos to make it appear to be momentum base with the hop, so it slows down as it reaches it's final hop
      //we'll use this variable to adjust the inputs
      var hop_multiplier = clamp(cos((mod_chained_move_timer/mod_chained_move_time)*pi*2) + 0.5, 0, 1);
      
      vector_to_inputs(mod_chained_vector_x, mod_chained_vector_y, hop_multiplier)
      
    } //end of attack inturruption 
    
    
}

return false;



//if we're in the correct event then activate



