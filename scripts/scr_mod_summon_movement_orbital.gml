///scr_mod_summon_movement_orbital()


///scr_mod_summon_movement_orbital()
//
//summon step event

if (object_index = obj_summon) || (object_index = obj_enemy){
    
    
    //init
    if !variable_instance_exists(self, "mod_summon_movement_orbital_start"){
      if is_summoned{
        dir = point_direction(owner_id.x, owner_id.y, x, y)
        cx = owner_id.x
        cy = owner_id.y
      }else{
        dir = 0
      }
      
      mod_summon_movement_orbital_mod_count = scr_queue_has_mod_count(step_event_queues, scr_mod_summon_movement_orbital)
      
      pre_x = start_x
      pre_y = start_y
      
      orbital_dist = sprite_width*(mod_summon_movement_orbital_mod_count + is_summoned) *0.5
      orbital_rot  = direction
      
      mod_summon_movement_orbital_start = true
    }
    
    //for the first mod keep track of the center x and y
    if (mod_summon_movement_orbital_start = true){
      cx = x - lengthdir_x(orbital_dist, orbital_rot)
      cy = y - lengthdir_y(orbital_dist, orbital_rot)
      
      if (is_summoned){
        cx = mean(cx,cx,cx, owner_id.x)
        cy = mean(cy,cy,cy, owner_id.y)
      }
      
      orbital_dist = sprite_width*(mod_summon_movement_orbital_mod_count + is_summoned)
      mod_summon_movement_orbital_start = false
    }
    
    var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_movement_orbital)+1;
    
    //for each modifier add in the calculations
    orbital_rot += (45/room_speed)*lag()
    
    if (orbital_rot >= 360) orbital_rot -= 360
    
    //reload the modifier
    //  this section is only here so we dont have to run the same mod 5 times but just
    //  once with the same calculations and just multiply the result by 5.
    if (mod_count = 1){
      //now that all modifiers are done adding to the new value we can adjust it's possition
      var new_x = cx+lengthdir_x(orbital_dist, orbital_rot)
      var new_y = cy+lengthdir_y(orbital_dist, orbital_rot)
      
      x = new_x
      y = new_y
      
      pre_x = x
      pre_y = y
      mod_summon_movement_orbital_start = true;
    }
    
}

return false;



//if we're in the correct event then activate



