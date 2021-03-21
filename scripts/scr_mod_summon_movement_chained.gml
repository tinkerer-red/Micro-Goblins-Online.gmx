///scr_mod_summon_movement_chained()


///scr_mod_summon_movement_chained()
//
//summon step event

if (object_index = obj_summon) || (object_index = obj_enemy){
    
    
    //init
    if !variable_instance_exists(self, "mod_summon_movement_chained_start"){
      
      mod_summon_movement_chained_mod_count = scr_queue_has_mod_count(step_event_queues, scr_mod_summon_movement_chained)
      show_debug_message("mod_summon_movement_chained_mod_count = "+string(mod_summon_movement_chained_mod_count))
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
      
      pre_x = start_x
      pre_y = start_y
      
      chained_dist_max = sprite_width*((mod_summon_movement_chained_mod_count + (is_summoned*0.5))*4 + 1)
      chained_dist = 0
      chained_rot  = direction
      mod_chained_move_time = room_speed/mod_summon_movement_chained_mod_count/3
      
      mod_summon_movement_chained_start = true
    }
    
    if (attack_active = false){ //if we arew not restrained by attack mods
      //for the first mod keep track of the center x and y
      if (mod_summon_movement_chained_start = true){
        mod_chained_desired_dir  = htme_random_range(0,360)
        mod_chained_desired_dist = htme_random_range(0,chained_dist_max)
        mod_chained_desired_x = mod_chained_cx+lengthdir_x(mod_chained_desired_dist, mod_chained_desired_dir)
        mod_chained_desired_y = mod_chained_cy+lengthdir_y(mod_chained_desired_dist, mod_chained_desired_dir)
        mod_chained_move_vector_dir  = point_direction(x, y, mod_chained_desired_x, mod_chained_desired_y)
        mod_chained_move_vector_dist = point_distance(x, y, mod_chained_desired_x, mod_chained_desired_y)
        
        //up to five hops per second 
        mod_chained_move_timer = mod_chained_move_time
        mod_chained_move_count = mod_summon_movement_chained_mod_count*3
        
        
        mod_summon_movement_chained_start = false
      }
      
      show_debug_player("mod_chained_desired_x = "+string(mod_chained_desired_x))
      show_debug_player("mod_chained_desired_y = "+string(mod_chained_desired_y))
      show_debug_player("mod_chained_move_vector_dir = "+string(mod_chained_move_vector_dir))
      show_debug_player("mod_chained_move_vector_dist = "+string(mod_chained_move_vector_dist))
      
      show_debug_player("mod_chained_move_timer = "+string(mod_chained_move_timer))
      show_debug_player("mod_chained_move_count = "+string(mod_chained_move_count))
      
      var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_movement_chained)+1;
      
      if (point_distance(mod_chained_cx, mod_chained_cy, x, y,) >= chained_dist_max){
            var array = mean_vectors(speed, 
                                    direction, 
                                    point_distance(x, y, mod_chained_cx, mod_chained_cy),
                                    point_direction(x, y, mod_chained_cx, mod_chained_cy));
            speed =  array[0]
            direction = array[1]
          }
      
      //reload the modifier
      //  this section is only here so we dont have to run the same mod 5 times but just
      //  once with the same calculations and just multiply the result by 5.
      if (mod_count = 1){
        if (mod_chained_move_timer <= 0){
        
          //if it's time to hop
          //if (mod_chained_move_timer <= 0){
            var array = mean_vectors(speed, 
                                    direction, 
                                    mod_chained_move_vector_dist/(6-mod_summon_movement_chained_mod_count)/3,
                                    mod_chained_move_vector_dir);
            
            speed =  array[0]
            direction = array[1]
          //}else{
            
          //}
          
          
          mod_chained_move_count--;
          mod_chained_move_timer = mod_chained_move_time
          
          if (mod_chained_move_count <= 0){
            mod_summon_movement_chained_start = true;
          }
          
        }else{
          speed = 0
          mod_chained_move_timer -= 1*lag()
        }
      }
    }
}

return false;



//if we're in the correct event then activate



