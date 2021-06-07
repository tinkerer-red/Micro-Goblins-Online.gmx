///scr_mod_summon_movement_chained()


///DESCRIPTION: Keep the entity chained to a location, (stack in the ground for enemies, player if summoned)
// Modcount = How much damage should be increased, and the distance of the chain's reach
//
//summon step event



//Entity Check, find out of the object using this script is actually an entity
if (object_index = obj_summon) || (object_index = obj_enemy){
  
  
  
  //Check the mod count to help optimize math, and skip un needed script executions
  var mod_count = scr_queue_has_mod_count(step_event_queues_temp, scr_mod_summon_DESIGN)+1
  
  
  
  //init
  if !variable_instance_exists(self, "mod_summon_movement_chained_start"){
    //init what ever values are needed
    mod_summon_movement_chained_timer = room_speed
    mod_summon_movement_chained_start = true
    mod_chained_dist_max = mod_count*one_tile*3 + one_tile
    mod_chained_cx = x
    mod_chained_cy = y
    mod_chained_max_speed = max_speed
    mod_chained_min_speed = max_speed - 0.05*mod_count
    
    
    //stat buffs
    e_damage += 0.25*mod_count
    max_speed = mod_chained_min_speed
  }
  
  
  
  //is this mod currently active? (for instance when the enemy is just finishing with a jump or shot, is the next jump/shot on a cool down?) This is primarily here incase another mod needs to highjack or prevent a specific mod from happening
  if (mod_summon_movement_chained_start){
   
    /////look for inputs/////
      //if possessed, grab player inputs
      if is_possessed{
        var possessed_vector_x = possesser_id.right - possesser_id.left;
        var possessed_vector_y = possesser_id.down - possesser_id.up;
      }else{
        var possessed_vector_x = 0;
        var possessed_vector_y = 0;
      }
      
      //if summoned update center x,y
      if (is_summoned){
        //center x and y
        mod_chained_cx = owner_id.x
        mod_chained_cy = owner_id.y
      }
      
      //grab the desired inputs for this mod, sometimes they are the given inputs, or manipulated inputs, sometimes they are the mirrored inputs of the enemy.
      //move the entity back to it's starting location if it's out of bounds
      if (point_distance(mod_chained_cx, mod_chained_cy, x, y,) >= mod_chained_dist_max){
        var mod_vector_x = mod_chained_cx - x;
        var mod_vector_y = mod_chained_cy - y;
        max_speed = mod_chained_max_speed
        show_debug_player("out of bounds")
      }else{
        var mod_vector_x = 0;
        var mod_vector_y = 0;
        max_speed = mod_chained_min_speed
      }
      
      //add the two inputs as desired, or simply take the player inputs, either way.
         //This is also where you will add any bias to the movements
      var true_vector_x = clamp( mod_vector_x + possessed_vector_x, -1, 1);
      var true_vector_y = clamp( mod_vector_y + possessed_vector_y, -1, 1);
    /////////////////////////  
    
    vector_to_inputs(true_vector_x, true_vector_y, 2)
      
    ///if cooldown is needed
    mod_summon_movement_chained_timer -= 1*lag()
    if !mod_summon_movement_chained_timer{
      //change active states, or what ever
    }
    
    
    //to prevent the mod from running an additional time this frame for no reason, simply turn off the active state of the mod.
    mod_summon_movement_chained_start = false
  }
  
  
  
  //if we're finished with the last mod for this frame, lets reset the mod count
  if (mod_count = 1){
    mod_summon_movement_chained_start = true
  }
  
  
}

return false;
